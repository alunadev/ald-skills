---
name: figma-reverse-engineering
description: Reverse engineering de diseños Figma para generar especificaciones técnicas completas listas para implementar en código. Usar cuando el usuario comparte capturas, exports o descripciones de un diseño en Figma y quiere documentarlo técnicamente, extraer tokens de diseño, entender la estructura de layouts, o preparar una spec para que un desarrollador o Claude Code lo implemente. También usar cuando el usuario dice "reverse engineering del diseño", "documenta este Figma", "quiero implementar este diseño", "dame las propiedades CSS de este diseño", "convierte este diseño a código", o cuando comparte pantallazos de Figma (layers, propiedades, canvas). Activar también cuando el usuario quiere crear documentación técnica de un diseño existente antes de pasarlo a Claude Code.
---

# Figma Reverse Engineering

Este skill guía la creación de una especificación técnica completa a partir de un diseño en Figma, lista para implementar en código sin ambigüedad.

## Qué produce este skill

Un documento `.md` con:
- Design tokens (colores, tipografía, espaciado)
- Estructura de componentes y secciones (mapeada del layer tree de Figma)
- CSS/HTML de referencia para cada sección
- Decisiones de diseño documentadas
- Comportamiento responsive
- Instrucciones listas para Claude Code

---

## Flujo de trabajo

### Fase 1 — Recopilación de información

Antes de documentar nada, recopilar estos inputs del usuario. No asumir ningún valor — preguntar siempre:

**Inputs mínimos necesarios:**
1. **Captura del diseño** — screenshot del canvas completo
2. **Layer tree de Figma** — captura del panel de capas (estructura de frames y grupos)
3. **Propiedades de cada sección** — captura del panel derecho de Figma (Auto layout, dimensiones, fill, etc.)
4. **Assets** — logo, imágenes, iconos que aparecen en el diseño

**Preguntas obligatorias antes de empezar:**
- ¿Cuál es la tipografía? (fuente, pesos)
- ¿Cuál es el color de fondo principal y el color de CTA?
- ¿Las propiedades del panel derecho que compartes corresponden a qué sección?
- ¿El formulario conecta con algún servicio externo? (Mailchimp, Substack, etc.)
- ¿Necesita ser responsive en mobile?
- ¿Cuál es el stack técnico? (HTML vanilla, Astro, Next.js, etc.)

**Regla clave**: Si el usuario no ha compartido algo, preguntar. Nunca asumir dimensiones, colores o comportamientos.

---

### Fase 2 — Extracción de Design Tokens

Una vez recibidos los inputs, extraer y documentar:

```css
:root {
  /* Colores — extraídos del Fill panel de Figma */
  --color-bg-primary:   #XXXXXX;
  --color-cta:          #XXXXXX;
  --color-text-white:   #FFFFFF;
  --color-text-muted:   rgba(255,255,255,0.75);
  --color-line:         rgba(255,255,255,0.2);

  /* Tipografía */
  --font-family: 'NombreFuente', sans-serif;

  /* Espaciado — extraído del Auto layout panel */
  --gap-section:        XXpx;   /* padding bottom de sección */
  --gap-inner:          XXpx;   /* gap entre elementos */
  --gap-navbar-h:       XXpx;   /* padding horizontal navbar */
  --max-width:          XXXXpx; /* ancho del canvas */
}
```

**Fuentes de cada valor:**
- Colores → panel Fill de Figma (hex exacto)
- Espaciado → panel Auto layout (padding, gap)
- Dimensiones → W/H del frame seleccionado
- Tipografía → preguntar al usuario si no está visible

---

### Fase 3 — Mapeo de estructura (Layer Tree)

Traducir el layer tree de Figma a estructura HTML semántica:

**Patrón de traducción:**

| Figma              | HTML                        |
|--------------------|-----------------------------|
| Frame (sección)    | `<section>` o `<footer>`    |
| Frame (navbar)     | `<nav>`                     |
| Auto layout V      | `display: flex; flex-direction: column` |
| Auto layout H      | `display: flex; flex-direction: row`    |
| Grid               | `display: grid`             |
| Component          | Elemento reutilizable       |
| Text               | `<p>`, `<h1>`, `<span>`     |
| Image              | `<img>`                     |
| Rectangle          | `<div>` con background      |
| Line               | `<hr>` o pseudo-element     |

**Documentar para cada sección:**
```
nombre-seccion/
├── Dimensiones: W x H, ¿Hug o fijo?
├── Background: color
├── Padding: top/right/bottom/left
├── Gap: entre hijos
├── Clip content: sí/no (importante para overflow)
└── Hijos: lista de elementos y su orden
```

---

### Fase 4 — Especificación por sección

Para cada sección del diseño, documentar:

**Template por sección:**

```markdown
### X.X Nombre Sección

**Propiedades del frame:**
| Propiedad   | Valor  |
|-------------|--------|
| Width       | XXXpx  |
| Height      | XXXpx o Hug |
| Background  | #XXXXXX |
| Padding     | Xpx Xpx |
| Gap         | XXpx   |
| Clip        | Sí/No  |

**HTML:**
[código HTML de la sección]

**CSS:**
[código CSS con custom properties]

**Notas:**
[decisiones de implementación no obvias]
```

---

### Fase 5 — Elementos interactivos y animaciones

Documentar por separado cualquier elemento que tenga comportamiento:

**Formularios:**
- ¿A qué servicio conecta? (Substack, Mailchimp, etc.)
- ¿Validación client-side necesaria?
- ¿Estados del botón? (loading, success, error)
- ¿CORS issues si se hace fetch directo? → documentar solución (proxy, redirect, etc.)

**Animaciones scroll:**
- Elemento animado y tipo de animación
- Punto de inicio y fin (en relación a la sección)
- Trigger: ¿cuándo empieza? ¿cuándo termina?
- Rotación, escala u otras transformaciones
- Fórmula del cálculo si es proporcional al scroll

**Ejemplo de documentación de animación:**
```javascript
// Pelota que rueda hacia abajo con scroll
// - Empieza: 40px bajo línea horizontal superior
// - Termina: 40px sobre línea horizontal inferior
// - Rotación: 360° cada 150px recorridos (circunferencia real de la pelota)
// - Transform: translateY en wrapper, rotate en imagen (separados para evitar espiral)
```

---

### Fase 6 — Responsive

Para cada breakpoint documentar qué cambia:

```css
@media (max-width: 768px) {
  /* Documentar: qué elementos cambian y por qué */
  /* Regla: si un valor se reduce, indicar el ratio (ej: 16px → 8px = mitad) */
}
```

**Preguntas a hacer al usuario sobre mobile:**
- ¿Qué elementos se ocultan en mobile?
- ¿El grid pasa de 2 columnas a 1?
- ¿La navegación se convierte en hamburger?
- ¿Hay elementos decorativos que se simplifican?

---

### Fase 7 — Stack técnico y decisiones finales

Documentar antes de pasar a implementación:

| Decisión          | Opción elegida | Por qué |
|-------------------|----------------|---------|
| Framework         | Astro/Next/Vanilla | razón |
| Iconos            | Lucide/Heroicons/SVG custom | razón |
| Formulario        | fetch/proxy/redirect | razón |
| Fuente            | Google Fonts / local | razón |
| Despliegue        | Vercel/Netlify/otro | razón |

---

### Fase 8 — Instrucciones para Claude Code

Al final del documento, incluir siempre un bloque listo para copiar:

```markdown
## Instrucciones para Claude Code

Stack: [framework, CSS approach, librerías]
Assets en /public: [lista de archivos]

Design tokens principales:
- Fondo: #XXXXXX
- CTA: #XXXXXX  
- Texto: #FFFFFF
- Fuente: [nombre] (pesos: [lista])

Secciones: [lista]
Elemento diferencial: [descripción del elemento más complejo]

[Adjuntar el documento de especificación completo]
```

---

## Reglas de calidad

### Nunca asumir — siempre preguntar
Si el usuario no ha dado un valor, preguntar antes de documentar. Un valor incorrecto en la spec se propaga a todo el código.

### Prioridad de fuentes de verdad
1. Valores exactos del panel de Figma (máxima prioridad)
2. Valores medidos por el usuario en Figma ("ocupa 792px en el canvas")
3. Estimaciones visuales (última opción, marcar como "estimado")

### Documentar el "por qué", no solo el "qué"
```css
/* MAL */
.court-line--vertical {
  top: -40px;
}

/* BIEN */
.court-line--vertical {
  top: -40px; /* sobrepasa 40px por encima de la línea horizontal superior */
              /* clip:false en Figma — el elemento sale del frame */
}
```

### Detectar conflictos de CSS antes de documentarlos
Antes de escribir cualquier regla CSS, verificar que no hay conflictos entre:
- `width` fijo + `padding` (usar `box-sizing: border-box`)
- `width` + `max-width` + `min-width` (simplificar con `min()`)
- `position: absolute` en hijo sin `position: relative` en padre
- `overflow: hidden` que corta elementos con `clip: false` en Figma

### Preguntar sobre mobile antes de asumir comportamiento
"¿Qué pasa con [elemento] en mobile?" antes de documentar cualquier media query.

---

## Iteración durante la implementación

Este skill no termina cuando se entrega el documento. Durante la implementación el usuario puede volver con:

- **Valores que no coinciden**: preguntar el valor exacto de Figma, actualizar la spec
- **Comportamientos no documentados**: añadir la sección correspondiente
- **Decisiones de CSS**: explicar el razonamiento, proponer alternativas
- **Bugs visuales**: pedir captura + código actual para diagnosticar

Mantener el documento actualizado con cada decisión tomada durante la implementación.

---

## Output final

El documento de especificación se guarda en `/mnt/user-data/outputs/[nombre-proyecto]-design-spec.md` y se presenta al usuario con `present_files`.

Estructura del documento:
1. Design Tokens
2. Estructura Global (layer tree traducido)
3. Sección por sección (HTML + CSS)
4. Elementos interactivos y animaciones
5. Responsive
6. Assets
7. Skeleton HTML completo
8. Decisiones de diseño
9. Stack técnico
10. Instrucciones para Claude Code
