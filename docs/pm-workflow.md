# PM Workflow — De idea a producción

Flujo completo de 11 pasos que cubre todo el ciclo: desde validar una idea hasta medir su impacto post-lanzamiento. Cada paso tiene una skill asignada, un output concreto, y condiciones de entrada.

```
DISCOVER → STRATEGIZE → SPECIFY → DESIGN → PLAN → BUILD → REVIEW → HARDEN → DOCUMENT → RELEASE → MEASURE
```

---

## 1. DISCOVER — Entender el problema

**Skill:** `user-discovery` · **Slash command:** `/discovery [segmento]`

**Cuándo usarlo:** Antes de escribir cualquier PRD. Cuando quieres entender por qué un metric bajó, validar una hipótesis, o explorar un nuevo segmento de usuarios.

**Input:** Área de investigación o segmento de usuarios
**Output:** Opportunity Statement — "Users who [context] struggle to [job] because [barrier]. If we solved this, [outcome]."

**Gate de salida:** Opportunity Statement con evidencia real (citas, métricas, comportamientos observados).

---

## 2. STRATEGIZE — Definir dirección

**Skill:** `product-strategy` · **Slash command:** `/strategy [producto u horizonte]`

**Cuándo usarlo:** Planning trimestral, desalineación en roadmap, área de producto nueva, OKRs. Después de discovery, antes de especificar features.

**Input:** Problema del negocio o contexto del producto
**Output:** North Star + Opportunity Tree + 3 bets con trade-offs explícitos

**Gate de salida:** Bet seleccionado y aprobado por stakeholders.

---

## 3. SPECIFY — Escribir el PRD

**Skill:** `prd-writer` · **Slash command:** `/prd [feature]`

**Cuándo usarlo:** Feature aprobada para construir. La idea ya está validada y la dirección estratégica está clara.

**Input:** Bet seleccionado + Opportunity Statements
**Output:** `docs/prd/YYYY-MM-DD-[feature].md` — Problem statement + Success metrics + Solution + Scope in/out + Rollout plan

**Gate de salida:** PRD con al menos 1 success metric medible (valor target + método de medición).

---

## 4. DESIGN — Explorar la solución

**Skills:** `brainstorming` + `brand-identity` + `frontend-design` + `interface-design`

**Cuándo usarlo:** Después de tener el PRD aprobado. Antes de empezar a planificar implementación.

**Input:** PRD aprobado
**Output:** `docs/designs/YYYY-MM-DD-[feature].md` — Diseño técnico + UI flows + decisiones arquitectónicas

**Gate de salida:** Design doc existe antes de abrir plan de implementación.

---

## 5. PLAN — Crear plan de implementación

**Skill:** `planning`

**Cuándo usarlo:** Cuando el diseño está aprobado y los requisitos son claros.

**Input:** Design doc + PRD
**Output:** `docs/plans/YYYY-MM-DD-[feature]-plan.md` — Tareas atómicas (1-2h máx), fases con gates, TDD-first

**Gate de salida:** Plan con tareas suficientemente pequeñas para ser completadas en una sesión.

---

## 6. BUILD — Implementar

**Workflow:** `full-stack-build` · **Slash command:** `/fullstack [feature]`

**Cadena interna:** API design (`api-design-principles`) → DB schema (`supabase-postgres`) → Frontend (`react-best-practices` + `vercel-composition-patterns`) → Deploy (`deploying-to-github`)

**Input:** Plan de implementación
**Output:** Código deployado + `docs/features/YYYY-MM-DD-[feature]/` (api.md + schema.md + implementation-notes.md)

**Gate de salida:** Feature live en producción + error monitoring activo.

---

## 7. REVIEW — Revisar el código

**Skill:** `requesting-code-review`

**Cuándo usarlo:** Antes de mergear cualquier PR. Especialmente antes del merge final de la feature.

**Input:** PR / diff
**Output:** Review con issues priorizados por severidad

**Gate de salida:** Issues críticos resueltos.

---

## 8. HARDEN — Robustecer

**Skill:** `error-handling-patterns`

**Cuándo usarlo:** Después del code review, antes del lanzamiento. Cuando hay paths de error sin manejar o la feature toca integraciones externas.

**Input:** Código implementado
**Output:** Error handling correcto en todos los paths críticos

---

## 9. DOCUMENT — Documentar

**Skills:** `codebase-documenter` + `maintaining-documentation`

**Cuándo usarlo:** Al completar la feature, antes del lanzamiento público.

**Input:** Código final + implementation-notes.md
**Output:** README actualizado + docs técnicos actualizados como fuente de verdad

---

## 10. RELEASE — Lanzar

**Workflow:** `feature-to-launch` · **Slash command:** `/feature-launch [feature]`

**Cadena interna:** `changelog-generator` → `product-launch` → rollout gates (5% → 25% → 100%)

**Input:** Feature live + PRD + implementation notes
**Output:** `docs/launches/YYYY-MM-DD-[feature]-launch.md` — GTM brief + checklists + fechas T+7 y T+30

**Gate de salida:** Error rate estable + rollback documentado + anuncio publicado.

---

## 11. MEASURE — Medir impacto

**Skill:** `product-analytics` · **Slash command:** `/metrics [feature o pregunta]`

**Cuándo usarlo:** T+7 y T+30 post-lanzamiento. Para comparar contra los success metrics del PRD.

**Input:** Success metrics del PRD + datos reales post-lanzamiento
**Output:** Análisis de impacto — ¿funcionó? ¿por qué? ¿qué replicar o descartar?

---

## Flujos acelerados

Para ideas nuevas antes del PRD:
```
/idea [descripción] → idea-validator → brainstorming → prd-writer
```

Para contenido y publicación:
```
/publish [idea o plataforma] → writing-system → edit pass → plataforma específica
```

Para debugging:
```
/debug [síntoma] → systematic-debugging → root cause → fix
```

---

## Índice de skills y workflows

Ver `skills/GLOBAL_SKILLS.md` para el índice completo con paths, propósitos y triggers de cada skill.
