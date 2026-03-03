# ALD Skills — Análisis y Roadmap

> Análisis del estado actual del repositorio `ald-skills` y plan de acción para construir el sistema definitivo de un Senior PM que desarrolla sus propios side projects.

---

## 1. Estado Actual: Lo que ya tienes (y está bien)

Tu repo tiene una arquitectura sólida. 18 skills con estructura consistente (`SKILL.md` + frontmatter YAML + `resources/`). Estos son los puntos fuertes:

**Base técnica cubierta:**
- `brainstorming` → Descubrimiento socrático antes de codear
- `planning` → Planes atómicos con TDD
- `react-best-practices` → Optimización React/Next.js
- `frontend-design` → UI production-grade
- `interface-design` → SaaS/dashboards
- `error-handling-patterns` → Resiliencia de apps
- `codebase-documenter` → Docs y READMEs
- `changelog-generator` → Release notes
- `deploying-to-github` → Version control automatizado
- `requesting-code-review` → Code review subagent
- `creating-skills` → Meta-skill para crear más skills ✅

**Base PM cubierta:**
- `prd-writer` → PRDs modernos con ejemplos AI (muy bueno, ya tiene 5 stages)
- `idea-validator` → Validación brutal de ideas antes de construir
- `brand-identity` → Design tokens, tech stack, voice & tone
- `linkedin-viral-post-writer` → Contenido para LinkedIn

---

## 2. Gaps Identificados

### Gaps PM (críticos para ti)
| Gap | Por qué importa |
|-----|----------------|
| Product strategy & positioning | No tienes dónde definir visión, bets, roadmap estratégico |
| Discovery interviews | El flujo de discovery está incompleto sin guías de entrevista |
| User research synthesis | Cómo convertir feedback raw en insights accionables |
| Metrics & analytics setup | Analytics tracking para apps propias |
| Competitive analysis | Framework para analizar competidores |
| Launch playbook | De "feature lista" a "feature en producción con usuarios" |

### Gaps técnicos (para side projects)
| Gap | Fuente disponible |
|-----|-------------------|
| Prompt engineering patterns | `github.com/wshobson/agents` (tienes la URL) |
| API design principles | `github.com/wshobson/agents` (tienes la URL) |
| PostgreSQL / Supabase | `skills.sh/supabase` (tienes la URL) |
| Systematic debugging | `github.com/obra/superpowers` (tienes la URL) |
| Security (env vars) | `github.com/varlock` (en tu README) |

### Gaps de contenido/escritura
| Gap | Fuente disponible |
|-----|-------------------|
| Blog writing | Tienes varias URLs de writing skills |
| Newsletter writing | Sin cubrir actualmente |
| Writing system (X/Twitter) | `github.com/ashemag/x-writing-system-skill` |

### Gaps estructurales
- No tienes `workflows/` bien desarrollados (solo `feature-documenter` y `systematic-debugging` sin terminar)
- `agent-workflow` existe como skill pero no como workflow ejecutable
- Falta un `CLAUDE.md` en la raíz para Claude Code

---

## 3. Skills a Importar y Adaptar (desde tus URLs)

### Prioridad Alta — Integrar directamente

**`prompt-engineering-patterns`** (de wshobson/agents)
- URL: `github.com/wshobson/agents/tree/main/plugins/llm-application-dev/skills/prompt-engineering-patterns`
- Adaptar: renombrar a `prompt-engineering-patterns/` y ajustar frontmatter a tu estilo

**`systematic-debugging`** (de obra/superpowers)
- URL: `github.com/obra/superpowers`
- Ya tienes el archivo en `workflows/systematic-debugging` pero incompleto — completarlo

**`supabase-postgres`** (de skills.sh/supabase)
- URL: `skills.sh/supabase/agent-skills/supabase-postgres-best-practices`
- Esencial para side projects con backend

**`api-design-principles`** (de wshobson/agents)
- URL: `github.com/wshobson/agents`
- Clave cuando estés diseñando APIs de tus apps

**`x-writing-system`** (de ashemag)
- URL: `github.com/ashemag/x-writing-system-skill`
- Para el sistema de escritura en X

### Prioridad Media — Evaluar antes de incluir

**`interface-design`** de skills.sh/dammyjay93 → Ya tienes la tuya propia, comparar y mergear lo mejor
**`vercel-react-best-practices`** de skills.sh/vercel-labs → Mergear con tu `react-best-practices` actual
**`codebase-documenter`** de ailabs-393 → Comparar con la tuya y extraer lo mejor
**`update-docs`** de skills.sh/vercel → Útil como workflow, no como skill standalone

### De PM Skills (skills.sh)
Estas skills son de alto valor para tu perfil:
- `product-strategy-frameworks` → Incluir en nuevo `product-strategy/`
- `discovery-interview-guide` → Incluir en nuevo `user-discovery/`
- `prd-generator` → Comparar con tu `prd-writer` actual (la tuya parece mejor)
- `launch-playbook` → Incluir en nuevo `product-launch/`
- `analytics-tracking-setup` → Incluir en nuevo `product-analytics/`

---

## 4. Skills Nuevas a Crear (originales)

Estas no existen en ninguna fuente externa y son específicas de tu perfil como Senior PM + Builder:

### `product-strategy/` ⭐ Prioridad 1
```yaml
name: product-strategy
description: Creates product strategy documents, positioning, bets, and roadmap narratives. 
Use when defining product vision, quarterly bets, OKRs, or strategic positioning.
```
Contenido: Vision framing, bet structure, opportunity sizing, north star metric, roadmap narrative.

### `user-discovery/` ⭐ Prioridad 1
```yaml
name: user-discovery
description: Guides discovery interviews, synthesis, and insight generation.
Use when preparing interviews, analyzing feedback, or synthesizing user research.
```
Contenido: Interview guides (problem/solution/intent), synthesis frameworks, insight to decision pipeline.

### `product-analytics/` ⭐ Prioridad 1
```yaml
name: product-analytics
description: Sets up analytics tracking, defines events, and creates measurement plans.
Use when instrumenting a new feature, defining KPIs, or setting up dashboards.
```
Contenido: Event taxonomy, funnel setup, retention cohorts, dashboard templates.

### `product-launch/` ⭐ Prioridad 2
```yaml
name: product-launch
description: Creates go-to-market plans and launch checklists for features and side projects.
Use when preparing a feature or product for public release.
```
Contenido: Launch checklist, GTM narrative, comms plan, rollout gates.

### `competitive-analysis/` Prioridad 2
```yaml
name: competitive-analysis
description: Structures competitive research and positioning analysis.
Use when evaluating competitors, defining differentiation, or entering new markets.
```

### `writing-system/` Prioridad 2
```yaml
name: writing-system
description: Personal writing system for blogs, newsletters, and social content.
Use when writing long-form content, newsletters, or social posts.
```
Basado en: ashemag x-writing-system + document-writer de onmax + tu estilo propio.

---

## 5. Estructura Final Recomendada del Repo

```
ald-skills/
├── README.md
├── architecture.md
├── CLAUDE.md                        ← NUEVO: instrucciones para Claude Code
├── skills/
│   ├── GLOBAL_SKILLS.md
│   │
│   ├── [ESTRATEGIA & PRODUCTO]
│   ├── product-strategy/            ← NUEVO
│   ├── user-discovery/              ← NUEVO
│   ├── competitive-analysis/        ← NUEVO
│   ├── product-analytics/           ← NUEVO
│   ├── product-launch/              ← NUEVO
│   ├── prd-writer/                  ← EXISTENTE ✅ (muy bueno)
│   ├── idea-validator/              ← EXISTENTE ✅
│   │
│   ├── [DISEÑO & FRONTEND]
│   ├── brand-identity/              ← EXISTENTE ✅
│   ├── design-guide/                ← EXISTENTE ✅
│   ├── frontend-design/             ← EXISTENTE ✅
│   ├── interface-design/            ← EXISTENTE ✅
│   │
│   ├── [DESARROLLO]
│   ├── brainstorming/               ← EXISTENTE ✅
│   ├── planning/                    ← EXISTENTE ✅
│   ├── react-best-practices/        ← EXISTENTE (mergear con vercel-labs)
│   ├── api-design-principles/       ← IMPORTAR de wshobson
│   ├── supabase-postgres/           ← IMPORTAR de skills.sh/supabase
│   ├── error-handling-patterns/     ← EXISTENTE ✅
│   ├── prompt-engineering-patterns/ ← IMPORTAR de wshobson
│   │
│   ├── [AGENTES & AI]
│   ├── agent-workflow/              ← EXISTENTE (mejorar)
│   │
│   ├── [DOCUMENTACIÓN]
│   ├── codebase-documenter/         ← EXISTENTE ✅ (comparar con ailabs)
│   ├── maintaining-documentation/   ← EXISTENTE ✅
│   ├── changelog-generator/         ← EXISTENTE ✅
│   │
│   ├── [ESCRITURA & CONTENIDO]
│   ├── writing-system/              ← NUEVO (blog + newsletter + X)
│   ├── linkedin-viral-post-writer/  ← EXISTENTE ✅
│   │
│   ├── [OPERACIONES]
│   ├── requesting-code-review/      ← EXISTENTE ✅
│   ├── deploying-to-github/         ← EXISTENTE ✅
│   ├── creating-skills/             ← EXISTENTE ✅
│   └── running-inventory-tasks/     ← EXISTENTE (specific to LALIGA)
│
└── workflows/
    ├── feature-documenter/          ← EXISTENTE (completar)
    ├── systematic-debugging/        ← COMPLETAR (archivo existe)
    ├── idea-to-prd/                 ← NUEVO: idea-validator → brainstorming → prd-writer
    ├── feature-to-launch/           ← NUEVO: prd → planning → build → changelog → launch
    └── content-publishing/          ← NUEVO: writing-system → linkedin/blog/newsletter
```

---

## 6. CLAUDE.md — El archivo que falta

El archivo más importante que no tienes. Va en la raíz de **cada proyecto** (no en el repo de skills) pero necesitas una plantilla. Este le dice a Claude Code quién eres y cómo trabajas:

```markdown
# Project: [Nombre del proyecto]

## Stack
- Frontend: Next.js 15, React 19, TypeScript, Tailwind, shadcn/ui
- Backend: [Supabase / PlanetScale / etc.]
- Deploy: Vercel

## Skills activos
@ald-skills/brainstorming
@ald-skills/planning
@ald-skills/frontend-design
@ald-skills/react-best-practices

## Convenciones
- Commits en inglés, mensajes en imperativo
- Componentes en PascalCase, funciones en camelCase
- Tests con Vitest
- Feature branches: feat/, fix/, chore/

## Contexto de negocio
[Qué hace el producto, a quién va dirigido, métricas de éxito]
```

---

## 7. Plan de Acción — Orden de Ejecución

### Sprint 1 — Esta semana (completar lo roto)
1. Completar `workflows/systematic-debugging` — tiene el archivo, falta el contenido
2. Importar y adaptar `prompt-engineering-patterns` desde wshobson
3. Crear `CLAUDE.md` template en la raíz

### Sprint 2 — Próxima semana (PM core)
4. Crear `product-strategy/SKILL.md`
5. Crear `user-discovery/SKILL.md`  
6. Crear `product-analytics/SKILL.md`
7. Crear workflow `idea-to-prd/`

### Sprint 3 — Siguientes 2 semanas (técnico + contenido)
8. Importar `supabase-postgres` y `api-design-principles`
9. Crear `writing-system/SKILL.md`
10. Crear workflow `feature-to-launch/`
11. Crear workflow `content-publishing/`

### Sprint 4 — Mantenimiento continuo
12. Mergear `react-best-practices` con vercel-labs skill
13. Actualizar `GLOBAL_SKILLS.md` con todas las nuevas skills
14. Revisar y refinar `running-inventory-tasks` (¿sigue siendo relevante?)

---

## 8. Recursos Pendientes de Evaluar

Estos los tienes en Notion pero aún no has evaluado si merecen ser skills o solo referencias:

| Recurso | Acción recomendada |
|---------|-------------------|
| `github.com/jarrodwatts/claude-code-config` | Leer y extraer lo mejor para tu `CLAUDE.md` template |
| `github.com/deanpeters/product-manager-prompts` | Revisar — puede haber prompts para mergear en tus PM skills |
| `github.com/google-labs-code/stitch-skills` | Evaluar para UI components |
| `prompt-kit.com` | Evaluar shadcn UI components para tus side projects |
| `github.com/ibelick/ui-skills` | Evaluar para `frontend-design` |
| `thegroundtruth.media` workflow article | Leer y extraer patrones para tu `CLAUDE.md` |
| `x.com/clairevo` post | Revisar tips para workflow personal |

---

## Resumen Visual

```
AHORA (18 skills, base sólida)
         ↓
SPRINT 1 (completar gaps críticos + prompt engineering)
         ↓
SPRINT 2 (convertirte en PM con superpoderes)
         ↓
SPRINT 3 (sistema completo de contenido + backend)
         ↓
SISTEMA FINAL (~30 skills + 5 workflows + CLAUDE.md template)
```

El objetivo no es tener el mayor número de skills, sino que cada skill represente una capacidad real que uses al menos una vez por semana. Las skills que no usas son ruido.
