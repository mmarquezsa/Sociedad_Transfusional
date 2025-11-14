#!/usr/bin/env python3
"""
Script para convertir gestion_noticias.html a gestion-miembros.html
Reemplaza todas las referencias de noticias por miembros
"""

import re

# Leer el archivo original
with open('gestion_noticias.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Diccionario de reemplazos
replacements = {
    # Títulos y etiquetas
    'Gestión de Noticias': 'Gestión de Miembros',
    'Gestión de Contenido': 'Gestión de Miembros',
    'Panel de Administración': 'Gestión de Miembros',
    'Agregar Nueva Noticia': 'Agregar Nuevo Miembro',
    'Gestionar Noticias': 'Gestionar Miembros',
    'Lista de Noticias': 'Lista de Miembros',
    'Nueva Noticia': 'Nuevo Miembro',
    'Total Noticias': 'Total Miembros',
    'Este Mes': 'Nuevos (mes)',
    'Categorías': 'Especialidades',
    'Usuarios': 'Ciudades',
    
    # Variables y constantes JavaScript
    'newsForm': 'memberForm',
    'newsList': 'membersList', 
    'news-form': 'member-form',
    'news-list': 'members-list',
    'news-title': 'member-name',
    'news-category': 'member-specialty',
    'news-date': 'member-date',
    'news-summary': 'member-description',
    'news-url': 'member-city',
    'news-image-file': 'member-image-file',
    'news-id': 'member-id',
    'submit-news': 'submit-member',
    'total-news': 'total-members',
    'recent-news': 'recent-members',
    'categories-count': 'specialties-count',
    'users-count': 'cities-count',
    
    # Texto de base de datos
    "'noticias'": "'miembros'",
    '"noticias"': '"miembros"',
    'localNewsData': 'localMembersData',
    
    # Funciones
    'loadNews': 'loadMembers',
    'handleNewsSubmit': 'handleMemberSubmit',
    'editNews': 'editMember',
    'deleteNews': 'deleteMember',
    
    # Mensajes
    'Noticia publicada': 'Miembro agregado',
    'Noticia actualizada': 'Miembro actualizado',
    'Noticia eliminada': 'Miembro eliminado',
    'Publicar Noticia': 'Agregar Miembro',
    'Actualizar Noticia': 'Actualizar Miembro',
    'Editando Noticia': 'Editando Miembro',
    'Cargando noticias': 'Cargando miembros',
    'No hay noticias': 'No hay miembros',
    
    # Iconos de dashboard
    '📰': '👥',
    '📅': '✨',
    '🏷️': '🎓',
    '👥': '🏙️',
    
    # SVG paths
    'd="M19 20H5 a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9.5a2.5 2.5 0 00-2.5-2.5H15"': 'd="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"',
}

# Aplicar reemplazos
for old, new in replacements.items():
    content = content.replace(old, new)

# Escribir el archivo convertido
with open('gestion-miembros.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("✅ Archivo gestion-miembros.html creado exitosamente!")
print("📝 Se realizaron", len(replacements), "reemplazos")
