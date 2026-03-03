# ALD Skills — Análisis y Roadmap

> Análisis del estado actual del repositorio `ald-skills` y plan de acción para construir el sistema definitivo de un Senior PM que desarrolla sus propios side projects.

**Última actualización:** 2026-03-03
**Sprints completados:** Sprint 1 ✅ Sprint 2 ✅

> **Decisiones cerradas (2026-03-03):**
> - `running-inventory-tasks` → **Eliminar completamente** del repo
> - `fullstack-developer` → **Skill standalone + Workflow `full-stack-build/`** (evaluar Shubhamsaboo primero en Sprint 3)
> - `react-best-practices` → **Upgrade** de la skill existente a la versión completa (8 categorías, 58 reglas). También evaluar `web-design-guidelines` y `vercel-composition-patterns` como nuevas skills independientes

---

## 1. Estado Actual

### Skills existentes (tras Sprint 1 + 2)

**Product Management (6 skills)**
- `product-strategy/` ✅ NUEVO Sprint 2 — North Star, Opportunity Tree, OKRs, 3 bets
- `user-discovery/` ✅ NUEVO Sprint 2 — Interview protocol, synthesis, Opportunity Statements
- `product-analytics/` ✅ NUEVO Sprint 2 — Metric tree, A/B design, tracking plan, HEART
- `prd-writer/` ✅ EXISTENTE — Gold standard (398 líneas), 5 stages
- `idea-validator/` ✅ EXISTENTE
- `brand-identity/` ✅ EXISTENTE — Design tokens, tech stack, voice & tone

**Engineering & Development (9 skills)**
- `prompt-engineering-patterns/` ✅ NUEVO Sprint 1 — 9-pattern library
- `brainstorming/` ✅
- `planning/` ✅
- `react-best-practices/` ✅ INCOMPLETO — versión parcial de vercel-react-best-practices (3/8 categorías; upgrade en Sprint 3)
- `frontend-design/` ✅
- `interface-design/` ✅
- `error-handling-patterns/` ✅
- `agent-workflow/` ✅
- `creating-skills/` ✅ meta-skill

**Documentation & Operations (6 skills)**
- `codebase-documenter/` ✅
- `maintaining-documentation/` ✅
- `changelog-generator/` ✅
- `deploying-to-github/` ✅
- `requesting-code-review/` ✅
- `linkedin-viral-post-writer/` ✅

**Workflows**
- `systematic-debugging/` ✅ NUEVO Sprint 1 — SKILL.md + `/debug` command
- `feature-documenter/` ✅ EXISTENTE

**Templates y Docs**
- `templates/CLAUDE.template.md` ✅ NUEVO Sprint 1
- `docs/roadmap.md` (este archivo)

---

## 2. Clasificación de Recursos Externos (Notion)

Evaluación completa de todos los recursos pendientes en Notion.

### ✅ Ya tienes una skill equivalente — no importar

| Recurso | Ya cubierto por |
|---------|----------------|
| `skills.sh/prd-generator` | `prd-writer/` (la tuya es mejor: 5 stages, más completa) |
| `skills.sh/discovery-interview-guide` | `user-discovery/` (Sprint 2) |
| `skills.sh/product-strategy-frameworks` | `product-strategy/` (Sprint 2) |
| `skills.sh/analytics-tracking-setup` | `product-analytics/` (Sprint 2) |
| `skills.sh/dammyjay93-interface-design` | `interface-design/` (existente) |
| `github.com/ailabs-393/codebase-documenter` | `codebase-documenter/` (existente, comparar y extraer lo mejor) |
| `skills.sh/vercel-react-best-practices` | `react-best-practices/` existente (tu skill YA es esta, pero incompleta — upgrade en Sprint 3 a las 8 categorías completas) |
| `skills.sh/vercel-labs` (4 skills en total) | Las 4: `vercel-react-best-practices` (upgrade), `web-design-guidelines` (nueva), `vercel-composition-patterns` (nueva), `vercel-react-native-skills` (nueva) |

### 🔴 Importar / Crear — Prioridad Alta

| Recurso | Acción | Sprint |
|---------|--------|--------|
| `skills.sh/supabase-postgres` | IMPORTAR y adaptar | Sprint 3 |
| `github.com/wshobson/agents` → `api-design-principles` | IMPORTAR y adaptar | Sprint 3 |
| `github.com/ashemag/x-writing-system-skill` | BASE para crear `writing-system/` propio | Sprint 3 |
| `skills.sh/launch-playbook` | BASE para crear `product-launch/` | Sprint 3 |
| `github.com/Shubhamsaboo/fullstack-developer` | EVALUAR primero → CREAR `fullstack-developer/` (skill) + `workflows/full-stack-build/` | Sprint 3 |

> **Nota `Shubhamsaboo/fullstack-developer`:** Evaluar el repo antes de crear. La skill de "fullstack developer" cubre el flujo completo de diseño → API → DB → deployment para side projects. No existe equivalente en ald_skills. Lo más probable es que sea una skill nueva que integre brainstorming + planning + react-best-practices + api-design + supabase en un workflow guiado. Evaluar si es mejor como skill standalone o como `workflows/full-stack-build/`.

### 🟡 Skills independientes — mantener separadas con cross-reference

Estas skills tienen valor propio y **no se deben mergear** con las existentes. En cambio, se referencian mutuamente.

| Skill nueva | Skill existente | Relación |
|-------------|-----------------|----------|
| `tailwind-design-system/` (de wshobson) | `brand-identity/` | `brand-identity` → "Ver también: tailwind-design-system para implementación en Tailwind" |
| `tailwind-design-system/` | `frontend-design/` | `frontend-design` → "Ver también: tailwind-design-system para tokens y configuración Tailwind" |
| `stitch-skills/` (de google-labs) | `frontend-design/` | `frontend-design` → "Ver también: stitch-skills para AI-generated UI components" |
| `stitch-skills/` | `interface-design/` | `interface-design` → "Ver también: stitch-skills para generación de componentes con IA" |
| `web-design-guidelines/` (vercel-labs) | `interface-design/` | Skill independiente — UI review, accessibility, UX audit. No merge con interface-design |
| `vercel-composition-patterns/` (vercel-labs) | `react-best-practices/` | Skill independiente — React composition patterns avanzados. Complementa pero no reemplaza |
| `vercel-react-native-skills/` (vercel-labs) | — | Skill independiente — React Native + Expo best practices para apps móviles |

**Plan de implementación:**
1. Crear `skills/tailwind-design-system/SKILL.md` adaptado del repo wshobson
2. Crear `skills/stitch-skills/SKILL.md` adaptado del repo google-labs
3. Añadir sección "Ver también" al final de `brand-identity/SKILL.md`, `frontend-design/SKILL.md`, `interface-design/SKILL.md`

### 🗑️ Eliminar del repo público — contexto específico de proyecto

| Recurso | Decisión | Destino |
|---------|----------|---------|
| `running-inventory-tasks/` | **ELIMINAR completamente** del repo — sin migrar | — |

### ⚙️ Commands (slash commands a crear)

| Command | Source | Sprint |
|---------|--------|--------|
| `/prd` | Activar `prd-writer` con contexto del proyecto | Sprint 3 |
| `/discovery` | Activar `user-discovery` con research brief | Sprint 3 |
| `/metrics` | Activar `product-analytics` con decision first | Sprint 3 |
| `/strategy` | Activar `product-strategy` con north star | Sprint 3 |

### 📖 Solo referencias — no crear skill

| Recurso | Por qué |
|---------|---------|
| `github.com/deanpeters/product-manager-prompts` | Prompts sueltos, no estructura de skill. Revisar y extraer los mejores como ejemplos en PM skills existentes |
| `github.com/jarrodwatts/claude-code-config` | Patrones para CLAUDE.md, no skill |
| `thegroundtruth.media` workflow article | Patrones de workflow, extraer al `CLAUDE.template.md` |
| `x.com/clairevo` post | Tips de workflow personal |
| `prompt-kit.com` | UI components shadcn para side projects (bookmark de referencia) |
| `github.com/ibelick/ui-skills` | Evaluar para `frontend-design` como referencia |

### ⏭️ Skip por ahora

| Recurso | Por qué |
|---------|---------|
| `skills.sh/vercel/update-docs` | Ya cubierto por `maintaining-documentation/` + `codebase-documenter/` |

---

## 3. Flujo PM Completo (post Sprint 2)

```
DISCOVER    → user-discovery      (interviews, synthesis, opportunity statements)
     ↓
STRATEGIZE  → product-strategy    (north star, bets, OKRs, positioning)
     ↓
SPECIFY     → prd-writer          (PRD moderno con success metrics)
     ↓
BUILD       → brainstorming → planning → react-best-practices → api-design → supabase-postgres
     ↓
REVIEW      → requesting-code-review
     ↓
HARDEN      → error-handling-patterns
     ↓
DOCUMENT    → codebase-documenter → changelog-generator
     ↓
RELEASE     → deploying-to-github → product-launch
     ↓
MEASURE     → product-analytics   (tracking, A/B, post-launch analysis)
```

---

## 4. Estructura Final del Repo (objetivo)

```
ald_skills/
├── README.md
├── GLOBAL_SKILLS.md
├── docs/
│   └── roadmap.md               ← este archivo
├── templates/
│   └── CLAUDE.template.md       ← ✅ Sprint 1
│
├── skills/
│   ├── GLOBAL_SKILLS.md
│   │
│   ├── [PRODUCT MANAGEMENT]
│   ├── product-strategy/        ✅ Sprint 2
│   ├── user-discovery/          ✅ Sprint 2
│   ├── product-analytics/       ✅ Sprint 2
│   ├── prd-writer/              ✅ existente
│   ├── idea-validator/          ✅ existente
│   ├── product-launch/          ← Sprint 3 (crear original)
│   │
│   ├── [DISEÑO & FRONTEND]
│   ├── brand-identity/          ✅ existente + cross-ref tailwind-design-system
│   ├── design-guide/            ✅ existente
│   ├── frontend-design/         ✅ existente + cross-ref tailwind-design-system, stitch-skills
│   ├── interface-design/        ✅ existente + cross-ref stitch-skills
│   ├── tailwind-design-system/  ← Sprint 3 (importar de wshobson)
│   ├── stitch-skills/           ← Sprint 3 (importar de google-labs)
│   │
│   ├── [DESARROLLO]
│   ├── brainstorming/           ✅ existente
│   ├── planning/                ✅ existente
│   ├── react-best-practices/        ✅ existente — upgrade a 8 categorías en Sprint 3
│   ├── vercel-composition-patterns/ ← Sprint 3 (importar de vercel-labs, separado)
│   ├── web-design-guidelines/       ← Sprint 3 (importar de vercel-labs, separado)
│   ├── vercel-react-native-skills/  ← Sprint 3 (importar de vercel-labs — mobile)
│   ├── api-design-principles/       ← Sprint 3 (importar de wshobson)
│   ├── supabase-postgres/           ← Sprint 3 (importar de skills.sh)
│   ├── error-handling-patterns/     ✅ existente
│   ├── prompt-engineering-patterns/ ✅ Sprint 1
│   ├── fullstack-developer/         ← Sprint 3 (evaluar Shubhamsaboo → crear original)
│   │
│   ├── [AGENTES & AI]
│   ├── agent-workflow/          ✅ existente (mejorar en Sprint 4)
│   │
│   ├── [DOCUMENTACIÓN]
│   ├── codebase-documenter/     ✅ existente
│   ├── maintaining-documentation/ ✅ existente
│   ├── changelog-generator/     ✅ existente
│   │
│   ├── [ESCRITURA & CONTENIDO]
│   ├── writing-system/          ← Sprint 3 (crear, base: ashemag)
│   ├── linkedin-viral-post-writer/ ✅ existente
│   │
│   ├── [OPERACIONES]
│   ├── requesting-code-review/  ✅ existente
│   ├── deploying-to-github/     ✅ existente
│   ├── creating-skills/         ✅ existente
│   └── running-inventory-tasks/ ← MOVER a ald-system/products/laliga/ (ver Sprint 3)
│
└── workflows/
    ├── systematic-debugging/    ✅ Sprint 1
    ├── feature-documenter/      ✅ existente
    ├── idea-to-prd/             ← Sprint 4 (idea-validator → brainstorming → prd-writer)
    ├── feature-to-launch/       ← Sprint 4 (prd → planning → build → changelog → launch)
    ├── full-stack-build/        ← Sprint 4 (evaluar como alternativa a fullstack-developer skill)
    └── content-publishing/      ← Sprint 4 (writing-system → linkedin/blog/newsletter)
```

---

## 5. Screaming Architecture — ald-system

El repo `ald-system` es la "carpeta de dotfiles del AI" — su estructura debe gritar lo que hace, no cómo está organizado técnicamente.

### Propuesta de estructura

```
ald-system/
├── CLAUDE.md                    ← instrucciones globales para Claude Code
├── ald_skills/                  ← submodule (portable, público)
│
├── products/                    ← contexto específico de cada proyecto
│   ├── laliga/
│   │   ├── CLAUDE.md            ← instrucciones específicas del proyecto
│   │   ├── skills/              ← skills solo para este proyecto
│   │   │   └── running-inventory-tasks/  ← migrado desde ald_skills
│   │   └── docs/
│   │       └── context.md       ← contexto de negocio, stack, decisiones
│   └── [otro-proyecto]/
│       └── CLAUDE.md
│
├── docs/                        ← documentación del sistema AI
│   ├── how-it-works.md
│   ├── ai-workflow.md
│   └── screaming-architecture.md  ← este análisis
│
└── templates/                   ← plantillas reutilizables
    ├── canonical-docs/          ← estructura de docs para nuevos proyectos
    │   ├── prd.md
    │   ├── app-flow.md
    │   ├── tech-stack.md
    │   ├── design-system.md
    │   ├── backend-structure/
    │   ├── implementation-plan.md
    │   ├── CLAUDE.md
    │   └── progress.txt         ← añadir en Sprint 3
    └── [otras plantillas]
```

### Canonical Docs Structure (para cada nuevo proyecto)

Basado en el análisis de la Notion page:

```
[proyecto]/
├── docs/
│   ├── product/
│   │   ├── prd.md               ← PRD principal
│   │   ├── app-flow.md          ← User flows y navegación
│   │   └── progress.txt         ← Estado actual, decisiones recientes
│   ├── design-system/
│   │   └── design-system.md     ← Tokens, componentes, guía visual
│   └── system/
│       ├── tech-stack.md        ← Stack técnico y justificación
│       ├── backend-structure/   ← Modelos, APIs, DB schema
│       └── implementation-plan.md
└── CLAUDE.md                    ← Skills activos, convenciones, contexto
```

---

## 6. Plan de Acción — Sprints Pendientes

### Sprint 3 — Técnico + Contenido + Correcciones
*~10 archivos nuevos o modificados*

**Upgrade skills existentes:**
1. Actualizar `skills/react-best-practices/SKILL.md` → incluir las 8 categorías completas (58 reglas) de vercel-react-best-practices (actualmente solo tiene 3/8)

**Importar desde fuentes externas:**
2. Crear `skills/supabase-postgres/SKILL.md` (base: skills.sh/supabase)
3. Crear `skills/api-design-principles/SKILL.md` (base: wshobson/agents)
4. Crear `skills/tailwind-design-system/SKILL.md` (base: wshobson, separado de brand-identity)
5. Crear `skills/stitch-skills/SKILL.md` (base: google-labs, separado de frontend-design)
6. Crear `skills/vercel-composition-patterns/SKILL.md` (base: vercel-labs, separado de react-best-practices)
7. Crear `skills/web-design-guidelines/SKILL.md` (base: vercel-labs, separado de interface-design)
8. Crear `skills/vercel-react-native-skills/SKILL.md` (base: vercel-labs — React Native + Expo)

**Evaluar y crear skills originales:**
9. Evaluar `github.com/Shubhamsaboo/fullstack-developer` → crear `skills/fullstack-developer/SKILL.md` (skill standalone)
10. Crear `workflows/full-stack-build/` (workflow encadenado basado en fullstack-developer)
11. Crear `skills/product-launch/SKILL.md`
12. Crear `skills/writing-system/SKILL.md` (base: ashemag + estilo propio)

**Cross-references:**
13. Añadir sección "Ver también" en `brand-identity/SKILL.md` → referencia a `tailwind-design-system`
14. Añadir sección "Ver también" en `frontend-design/SKILL.md` → referencia a `tailwind-design-system` + `stitch-skills` + `vercel-composition-patterns`
15. Añadir sección "Ver también" en `interface-design/SKILL.md` → referencia a `stitch-skills` + `web-design-guidelines`
16. Añadir sección "Ver también" en `react-best-practices/SKILL.md` → referencia a `vercel-composition-patterns`

**Slash commands:**
17. Crear command `/prd` (activa prd-writer con contexto del proyecto)
18. Crear command `/discovery` (activa user-discovery con research brief)
19. Crear command `/metrics` (activa product-analytics con decision first)
20. Crear command `/strategy` (activa product-strategy con north star)

**Limpieza:**
21. Eliminar `skills/running-inventory-tasks/` completamente del submodule

**Templates:**
22. Añadir `progress.txt` al `templates/CLAUDE.template.md`

### Sprint 4 — Workflows encadenados
*Workflows que conectan múltiples skills*

1. Crear `workflows/idea-to-prd/` — `idea-validator → brainstorming → prd-writer`
2. Crear `workflows/feature-to-launch/` — `prd → planning → build → changelog → product-launch`
3. Crear `workflows/content-publishing/` — `writing-system → linkedin / blog / newsletter`
4. Evaluar y mejorar `agent-workflow/`

### Sprint 5 — Screaming Architecture
*Restructurar ald-system para que su estructura grite su propósito*

1. Crear `ald-system/products/laliga/` con `CLAUDE.md` + skills específicas
2. Crear `ald-system/templates/canonical-docs/` con estructura de Canonical Docs
3. Actualizar `ald-system/CLAUDE.md` global
4. Documentar el sistema en `ald-system/docs/how-it-works.md`

### Sprint 6 — Mantenimiento y cierre
1. Actualizar `GLOBAL_SKILLS.md` con todas las skills de Sprint 3+4
2. Revisar y refinar cualquier skill con poco uso
3. Documentar el flujo PM completo en `docs/pm-workflow.md`
4. Publicar README.md mejorado en ald_skills

---

## 7. Decisiones Cerradas

Todas las decisiones pendientes han sido confirmadas.

| Decisión | Resolución |
|----------|------------|
| `running-inventory-tasks` | **Eliminar completamente** del repo en Sprint 3 |
| `fullstack-developer` | **Skill standalone + Workflow** `full-stack-build/` — evaluar Shubhamsaboo primero en Sprint 3 |
| `react-best-practices` + vercel-labs | **Upgrade** de la skill existente a las 8 categorías completas. `vercel-composition-patterns` y `web-design-guidelines` se crean como skills independientes |
| `tailwind-design-system` vs `brand-identity` | **Mantener separadas** — solo cross-reference |
| `stitch-skills` vs `frontend-design` | **Mantener separadas** — solo cross-reference |

---

## 8. Resumen Visual

```
COMPLETADO
Sprint 1 ✅ (systematic-debugging, prompt-engineering-patterns, CLAUDE.template.md)
Sprint 2 ✅ (product-strategy, user-discovery, product-analytics)

PRÓXIMO
Sprint 3 → api-design, supabase, tailwind-design-system, stitch-skills,
           product-launch, writing-system, fullstack-developer,
           cross-references, slash commands, running-inventory-tasks cleanup

Sprint 4 → workflows encadenados (idea-to-prd, feature-to-launch, content-publishing)

Sprint 5 → Screaming Architecture en ald-system + canonical-docs template

Sprint 6 → GLOBAL_SKILLS.md, README, documentación del sistema

OBJETIVO FINAL
~32 skills + 6 workflows + CLAUDE.template.md + Screaming Architecture
= Sistema completo de un Senior PM que construye sus propios productos con AI
```

> **Principio rector:** No importar skills que ya tienes cubiertas. Cada skill nueva debe representar una capacidad real que usarás al menos una vez por semana. Las skills que no usas son ruido.
