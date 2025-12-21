// ============================================
// AUTH.JS - Sistema de Autenticación SOCHIMT
// ============================================

// Configuración de Supabase
const SUPABASE_URL = 'https://dkohwhosputnxismgkon.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRrb2h3aG9zcHV0bnhpc21na29uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAwMzkxMTQsImV4cCI6MjA2NTYxNTExNH0.2ZOwkilUv49SADBzjrq-4AHUUKnMLZs-beftr3FLdAE';

// Inicializar Supabase Client
const { createClient } = supabase;
const supabaseClient = createClient(SUPABASE_URL, SUPABASE_KEY);

// ============================================
// FUNCIONES DE AUTENTICACIÓN
// ============================================

/**
 * Login de socio
 */
async function loginSocio(email, password, rememberMe = false) {
  try {
    console.log('🔐 Intentando login para:', email);
    
    // Intentar login con Supabase Auth
    const { data, error } = await supabaseClient.auth.signInWithPassword({
      email: email,
      password: password
    });

    if (error) {
      console.error('❌ Error en login:', error);
      throw new Error(error.message === 'Invalid login credentials' 
        ? 'Email o contraseña incorrectos' 
        : error.message);
    }

    console.log('✅ Login exitoso:', data.user.email);

    // Guardar en localStorage si "recordarme" está activado
    if (rememberMe) {
      localStorage.setItem('remember_me', 'true');
    }

    // Verificar si el usuario existe en la tabla socios
    const { data: socioData, error: socioError } = await supabaseClient
      .from('socios')
      .select('*')
      .eq('id', data.user.id)
      .single();

    if (socioError && socioError.code !== 'PGRST116') {
      console.error('❌ Error al verificar socio:', socioError);
    }

    // Si no existe en la tabla socios, crear registro básico
    if (!socioData) {
      console.log('📝 Creando perfil de socio...');
      const { error: insertError } = await supabaseClient
        .from('socios')
        .insert({
          id: data.user.id,
          email: data.user.email,
          nombre_completo: data.user.user_metadata?.nombre_completo || email.split('@')[0],
          estado: 'pendiente'
        });

      if (insertError) {
        console.error('⚠️ No se pudo crear perfil:', insertError);
      }
    }

    // Registrar log de acceso
    try {
      await supabaseClient.from('logs_acceso').insert({
        socio_id: data.user.id,
        accion: 'login',
        ip_address: await getClientIP(),
        user_agent: navigator.userAgent
      });
    } catch (logError) {
      console.warn('⚠️ No se pudo registrar log:', logError);
    }

    // Actualizar último acceso
    try {
      await supabaseClient
        .from('socios')
        .update({ ultimo_acceso: new Date().toISOString() })
        .eq('id', data.user.id);
    } catch (updateError) {
      console.warn('⚠️ No se pudo actualizar último acceso:', updateError);
    }

    // Redirigir al dashboard
    window.location.href = 'dashboard-socios.html';
    
  } catch (error) {
    console.error('💥 Error en loginSocio:', error);
    throw error;
  }
}

/**
 * Registro de nuevo socio
 */
async function registrarSocio(email, password, nombreCompleto, datos = {}) {
  try {
    console.log('📝 Registrando nuevo socio:', email);
    
    // Crear usuario en Supabase Auth
    const { data, error } = await supabaseClient.auth.signUp({
      email: email,
      password: password,
      options: {
        data: {
          nombre_completo: nombreCompleto
        }
      }
    });

    if (error) {
      console.error('❌ Error en registro:', error);
      throw new Error(error.message);
    }

    console.log('✅ Usuario creado en Auth:', data.user.email);

    // Crear perfil en tabla socios
    const { error: profileError } = await supabaseClient
      .from('socios')
      .insert({
        id: data.user.id,
        email: email,
        nombre_completo: nombreCompleto,
        rut: datos.rut || null,
        fecha_nacimiento: datos.fecha_nacimiento || null,
        sexo: datos.sexo || null,
        telefono: datos.telefono || null,
        profesion: datos.profesion || null,
        especialidad: datos.profesion || datos.especialidad || null,
        universidad: datos.universidad || null,
        registro_sis: datos.registro_sis || null,
        anos_experiencia: datos.anos_experiencia || null,
        institucion: datos.institucion || null,
        cargo: datos.cargo || null,
        ciudad: datos.ciudad || null,
        categoria: datos.categoria || null,
        patrocinador1_nombre: datos.patrocinador1_nombre || null,
        patrocinador1_rut: datos.patrocinador1_rut || null,
        patrocinador2_nombre: datos.patrocinador2_nombre || null,
        patrocinador2_rut: datos.patrocinador2_rut || null,
        url_cv: datos.url_cv || null,
        url_antecedentes: datos.url_antecedentes || null,
        url_registro_sis: datos.url_registro_sis || null,
        url_firma_patrocinadores: datos.url_firma_patrocinadores || null,
        url_otro_documento: datos.url_otro_documento || null,
        carpeta_documentos: datos.carpeta_documentos || null,
        recibir_newsletter: datos.recibir_newsletter || false,
        fecha_postulacion: datos.fecha_postulacion || new Date().toISOString().split('T')[0],
        fecha_ingreso: new Date().toISOString().split('T')[0],
        estado: 'pendiente',
        tipo_membresia: datos.tipo_membresia || 'regular'
      });

    if (profileError) {
      console.error('❌ Error al crear perfil:', profileError);
      console.error('❌ Código:', profileError.code);
      console.error('❌ Mensaje:', profileError.message);
      console.error('❌ Detalles:', profileError.details);
      console.error('❌ Hint:', profileError.hint);
      throw new Error('Error al crear perfil de socio: ' + profileError.message);
    }

    console.log('✅ Perfil de socio creado exitosamente');

    // Mostrar mensaje de éxito
    return {
      success: true,
      message: 'Registro exitoso. Por favor verifica tu email.',
      requiresEmailVerification: true
    };
    
  } catch (error) {
    console.error('💥 Error en registrarSocio:', error);
    throw error;
  }
}

/**
 * Logout de socio
 */
async function logoutSocio() {
  try {
    console.log('🚪 Cerrando sesión...');
    
    const { error } = await supabaseClient.auth.signOut();
    
    if (error) {
      console.error('❌ Error en logout:', error);
      throw error;
    }

    // Limpiar localStorage
    localStorage.removeItem('remember_me');
    
    console.log('✅ Sesión cerrada exitosamente');
    
    // Redirigir al login
    window.location.href = 'login-socios.html';
    
  } catch (error) {
    console.error('💥 Error en logoutSocio:', error);
    throw error;
  }
}

/**
 * Verificar si hay sesión activa
 */
async function checkAuth() {
  try {
    const { data: { session }, error } = await supabaseClient.auth.getSession();
    
    if (error) {
      console.error('❌ Error al verificar sesión:', error);
      return null;
    }

    if (!session) {
      console.log('⚠️ No hay sesión activa');
      return null;
    }

    console.log('✅ Sesión activa:', session.user.email);
    return session;
    
  } catch (error) {
    console.error('💥 Error en checkAuth:', error);
    return null;
  }
}

/**
 * Obtener datos del socio actual
 */
async function getSocioActual() {
  try {
    const { data: { user }, error } = await supabaseClient.auth.getUser();
    
    if (error || !user) {
      throw new Error('No hay usuario autenticado');
    }

    // Obtener datos completos del socio
    const { data: socioData, error: socioError } = await supabaseClient
      .from('socios')
      .select('*')
      .eq('id', user.id)
      .single();

    if (socioError) {
      console.error('❌ Error al obtener datos del socio:', socioError);
      return {
        id: user.id,
        email: user.email,
        nombre_completo: user.user_metadata?.nombre_completo || user.email.split('@')[0],
        estado: 'pendiente'
      };
    }

    return socioData;
    
  } catch (error) {
    console.error('💥 Error en getSocioActual:', error);
    throw error;
  }
}

/**
 * Verificar si el socio está activo
 */
async function isSocioActivo() {
  try {
    const socio = await getSocioActual();
    
    // Verificar estado
    if (socio.estado !== 'activo') {
      return false;
    }

    // Verificar fecha de vencimiento si existe
    if (socio.fecha_vencimiento) {
      const hoy = new Date();
      const vencimiento = new Date(socio.fecha_vencimiento);
      if (vencimiento < hoy) {
        return false;
      }
    }

    return true;
    
  } catch (error) {
    console.error('💥 Error en isSocioActivo:', error);
    return false;
  }
}

/**
 * Proteger página - requiere login
 */
async function requireAuth() {
  const session = await checkAuth();
  
  if (!session) {
    console.log('🔒 Acceso denegado - redirigiendo a login');
    window.location.href = 'login-socios.html';
    return false;
  }

  return true;
}

/**
 * Proteger página - requiere membresía activa
 */
async function requireActiveMembresia() {
  const isAuth = await requireAuth();
  if (!isAuth) return false;

  const isActive = await isSocioActivo();
  
  if (!isActive) {
    console.log('⚠️ Membresía no activa - redirigiendo');
    alert('Tu membresía no está activa. Por favor contacta con administración.');
    window.location.href = 'dashboard-socios.html';
    return false;
  }

  return true;
}

/**
 * Recuperar contraseña
 */
async function recuperarPassword(email) {
  try {
    console.log('📧 Enviando email de recuperación a:', email);
    
    const { error } = await supabaseClient.auth.resetPasswordForEmail(email, {
      redirectTo: window.location.origin + '/reset-password.html'
    });

    if (error) {
      console.error('❌ Error al enviar email:', error);
      throw error;
    }

    console.log('✅ Email de recuperación enviado');
    return { success: true, message: 'Revisa tu email para restablecer tu contraseña' };
    
  } catch (error) {
    console.error('💥 Error en recuperarPassword:', error);
    throw error;
  }
}

/**
 * Actualizar perfil de socio
 */
async function actualizarPerfil(datos) {
  try {
    const socio = await getSocioActual();
    
    console.log('📝 Actualizando perfil del socio:', socio.id);
    
    const { error } = await supabaseClient
      .from('socios')
      .update(datos)
      .eq('id', socio.id);

    if (error) {
      console.error('❌ Error al actualizar perfil:', error);
      throw error;
    }

    console.log('✅ Perfil actualizado exitosamente');
    return { success: true, message: 'Perfil actualizado correctamente' };
    
  } catch (error) {
    console.error('💥 Error en actualizarPerfil:', error);
    throw error;
  }
}

// ============================================
// UTILIDADES
// ============================================

/**
 * Obtener IP del cliente (aproximada)
 */
async function getClientIP() {
  try {
    const response = await fetch('https://api.ipify.org?format=json');
    const data = await response.json();
    return data.ip;
  } catch (error) {
    console.warn('⚠️ No se pudo obtener IP:', error);
    return 'unknown';
  }
}

/**
 * Formatear fecha
 */
function formatDate(dateString) {
  if (!dateString) return '';
  const date = new Date(dateString);
  return date.toLocaleDateString('es-CL', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });
}

/**
 * Validar RUT chileno
 */
function validarRUT(rut) {
  // Limpiar RUT
  rut = rut.replace(/\./g, '').replace(/-/g, '');
  
  if (rut.length < 8) return false;
  
  const rutDigits = rut.slice(0, -1);
  const rutDV = rut.slice(-1).toUpperCase();
  
  // Calcular dígito verificador
  let suma = 0;
  let multiplo = 2;
  
  for (let i = rutDigits.length - 1; i >= 0; i--) {
    suma += parseInt(rutDigits[i]) * multiplo;
    multiplo = multiplo === 7 ? 2 : multiplo + 1;
  }
  
  const resto = suma % 11;
  const dvCalculado = resto === 0 ? '0' : resto === 1 ? 'K' : String(11 - resto);
  
  return dvCalculado === rutDV;
}

/**
 * Formatear RUT
 */
function formatearRUT(rut) {
  // Limpiar
  rut = rut.replace(/\./g, '').replace(/-/g, '');
  
  if (rut.length <= 1) return rut;
  
  const rutDigits = rut.slice(0, -1);
  const rutDV = rut.slice(-1);
  
  // Agregar puntos
  let rutFormateado = '';
  let contador = 0;
  
  for (let i = rutDigits.length - 1; i >= 0; i--) {
    rutFormateado = rutDigits[i] + rutFormateado;
    contador++;
    if (contador === 3 && i !== 0) {
      rutFormateado = '.' + rutFormateado;
      contador = 0;
    }
  }
  
  return rutFormateado + '-' + rutDV;
}

// ============================================
// LISTENER DE CAMBIOS DE AUTENTICACIÓN
// ============================================

supabaseClient.auth.onAuthStateChange((event, session) => {
  console.log('🔄 Auth state changed:', event);
  
  if (event === 'SIGNED_IN') {
    console.log('✅ Usuario autenticado:', session.user.email);
  }
  
  if (event === 'SIGNED_OUT') {
    console.log('🚪 Usuario desautenticado');
  }
  
  if (event === 'TOKEN_REFRESHED') {
    console.log('🔄 Token actualizado');
  }
});

// Exportar funciones para uso global
window.loginSocio = loginSocio;
window.registrarSocio = registrarSocio;
window.logoutSocio = logoutSocio;
window.checkAuth = checkAuth;
window.getSocioActual = getSocioActual;
window.isSocioActivo = isSocioActivo;
window.requireAuth = requireAuth;
window.requireActiveMembresia = requireActiveMembresia;
window.recuperarPassword = recuperarPassword;
window.actualizarPerfil = actualizarPerfil;
window.validarRUT = validarRUT;
window.formatearRUT = formatearRUT;
window.supabaseClient = supabaseClient;

console.log('✅ Auth.js cargado correctamente');
