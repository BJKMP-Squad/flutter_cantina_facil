# 03 — Processo, Equipe e GitHub (Rodada 3)

> **Projeto:** Cantina Fácil · **Atualizado:** 2026-11-11 · **Status:** Rodada 3 concluída — aguardando gate para Rodada 4

## 1. Decisões da Rodada 3

| # | Pergunta | Resposta |
|---|---|---|
| P1 | Repositório de publicação | **(a)** `BJKMP-Squad/flutter_cantina_facil` (público, `main`) |
| P2 | Project v2 | **(c)** Criar novo: **Cantina Fácil — Kanban** (não reutilizar o #2 legado) |
| P3 | Equipe e calendário | **(a)** 5 pessoas × 8 h/semana; S1 10–16/11 · S2 17–23/11 · S3 24–30/11 |
| P4 | Branches e PR | **(a)** `main` protegida + `feature/CF-xxx` + PR com revisão |
| P5 | Convenções | **(a)** `CF-001`, labels pt-BR, colunas Backlog/Ready/Em progresso/Em revisão/Done |

## 2. Ambiente confirmado (somente leitura)

- `gh` 2.100.0 autenticado como `esdrascps`, escopos `repo`, `project`, `read:org`.
- Repo de publicação: `BJKMP-Squad/flutter_cantina_facil` — público, branch `main`, **0 issues**.
- Project legado #2 ("Kanban Cantina Facil") com 21 issues do repo privado `BJKMP-Squad/CantinaFacil` — **não será tocado**; o novo Project nasce limpo.
- Labels atuais: apenas as padrão do GitHub; as labels do projeto serão criadas do zero.

## 3. Equipe e capacidade

| Item | Valor |
|---|---|
| Pessoas | 5 |
| Horas/semana por pessoa | 8 h |
| Fator de foco | 0,7 |
| **Capacidade por sprint (1 semana)** | **28 h** (5 × 8 × 0,7) |
| Conversão de estimativa | ~1 ponto ≈ 3 h (tabela do PROMPT §9.4) |
| **Capacidade estimada** | **~9 pontos/sprint** · **~27 pontos no ciclo** |
| Comprometido no MVP | **27 pontos** (capacidade nominal, sem buffer; itens Should ficam no Backlog) |

> Regra: o backlog das 3 sprints **não pode exceder ~24 pontos**. O que não couber fica em `Backlog` (pós-MVP) ou é fatiado.

## 4. Calendário de sprints

| Sprint | Início | Fim | Meta |
|---|---|---|---|
| Sprint 1 | 10/11/2026 (ter) | 16/11/2026 (seg) | **Fundação e acesso** — app + Supabase + auth + RLS + tema/rotas + CI |
| Sprint 2 | 17/11/2026 (ter) | 23/11/2026 (seg) | **Fluxo de venda** — busca aluno, carrinho, RPC de venda, recarga, saldo/extrato realtime |
| Sprint 3 | 24/11/2026 (ter) | 30/11/2026 (seg) | **Gestão e entrega** — CRUD produtos c/ imagem, aprovação de vínculos, relatório básico, testes E2E, acessibilidade |

Milestones no GitHub: `Sprint 1` (due 2026-11-16), `Sprint 2` (due 2026-11-23), `Sprint 3` (due 2026-11-30).

## 5. Cerimônias

| Cerimônia | Quando | Duração | Saída |
|---|---|---|---|
| Planning | terça, início da sprint, 19h | 60 min | Sprint backlog priorizado + meta da sprint |
| Daily | diário, 19h (texto no chat se não houver sync) | 15 min | impedimentos e ajustes |
| Review/Demo | segunda, fim da sprint, 19h | 30 min | CAs aceitos ou reabertos |
| Retrospectiva | após a review | 30 min | 1 ação de melhoria para a próxima sprint |

Carga de cerimônias: ~2 h/semana (dentro do fator de foco).

## 6. Definition of Ready (DoR)

- [ ] História no formato `Como … quero … para …`
- [ ] Critérios de aceite testáveis (CA01, CA02…)
- [ ] Pelo menos 1 cenário BDD feliz + 1 de exceção
- [ ] Dependências identificadas (`depende de CF-xxx`)
- [ ] Estimada (pontos) e priorizada
- [ ] Dúvidas de negócio resolvidas
- [ ] Tela/protótipo de referência disponível quando houver UI (Figma)

## 7. Definition of Done (DoD)

- [ ] Código revisado e aprovado por outra pessoa (1 approval)
- [ ] Testes unitários e de widget passando
- [ ] `flutter analyze` sem erros
- [ ] Critérios de aceite validados (staging/homologação)
- [ ] RLS/policies testadas quando a história tocar dados
- [ ] Acessibilidade básica verificada (semântica, contraste, toque ≥ 48 dp)
- [ ] Documentação atualizada (README/ADR quando aplicável)
- [ ] Issue fechada e `Status` = `Done`

## 8. Convenções de branch, commit e PR

**Branches**

- `feature/CF-012-pdv-busca-aluno`
- `fix/CF-034-saldo-negativo`
- `chore/CF-003-ci-github-actions`
- `docs/CF-001-readme`

**Commits** (Conventional Commits, em inglês)

- `feat(pdv): add student search by name or enrollment`
- `fix(saldo): prevent negative balance on concurrent sale`
- `chore(ci): add flutter analyze and test workflow`

**Pull Requests**

- Template com checklist: `analyze` ✅, `test` ✅, CAs marcados, acessibilidade, RLS quando aplicável.
- Título: `[CF-012] PDV — busca de aluno`
- Corpo com `Closes #<issue>`; merge por **squash**.
- `main` protegida: PR obrigatório + 1 review + checks de CI verdes.

## 9. Kanban: colunas, WIP e regras

| Coluna | Significado | WIP |
|---|---|---|
| **Backlog** | itens priorizados sem sprint definida | sem limite |
| **Ready** | atende ao DoR e está pronto para puxar | ≤ 8 |
| **Em progresso** | em desenvolvimento, com responsável | ≤ 5 (1 por pessoa) |
| **Em revisão** | PR aberto aguardando review | ≤ 3 |
| **Done** | atende ao DoD e issue fechada | sem limite |

Regras: item só entra em `Ready` com DoR completo; só vai para `Done` com DoD completo; itens bloqueados recebem label `bloqueado` e continuam visíveis.

## 10. Labels

| Grupo | Labels |
|---|---|
| Tipo | `tipo:feature`, `tipo:bug`, `tipo:tech`, `tipo:docs`, `tipo:spike` |
| Área | `area:auth`, `area:aluno`, `area:pdv`, `area:saldo`, `area:produto`, `area:gestao`, `area:infra` |
| Prioridade | `prio:p0`, `prio:p1`, `prio:p2`, `prio:p3` |
| Tamanho | `tam:pp`, `tam:p`, `tam:m`, `tam:g` |
| Estado especial | `bloqueado`, `dependencia-externa` |

## 11. Campos do Project (novo)

| Campo | Tipo | Valores |
|---|---|---|
| `Status` (nativo) | Single select | Backlog, Ready, Em progresso, Em revisão, Done |
| `Prioridade` | Single select | P0 - Bloqueante, P1 - Alta, P2 - Média, P3 - Baixa |
| `Tamanho` | Single select | 1, 2, 3, 5, 8, 13 |
| `Sprint` | Single select | Backlog, Sprint 1, Sprint 2, Sprint 3 |
| `Área` | Single select | Auth, Aluno, PDV, Saldo, Produto, Gestão, Infra |
| `Estimativa` | Number | pontos (espelha Tamanho) |
| `Início` / `Alvo` | Date | planejamento de roadmap |

## 12. Views

| View | Layout | Filtro |
|---|---|---|
| `Kanban — Sprint atual` | Board | `-status:Done` |
| `Backlog` | Table | `status:Backlog` |
| `Bugs` | Table | `label:"tipo:bug"` |
| `Roadmap` | Roadmap | — |
| `Meus itens` | Table | `assignee:@me` |

## 13. Riscos de processo

| Risco | Impacto | Mitigação |
|---|---|---|
| Capacidade apertada (~24 pts) | Alto | Fatiar histórias em 1–3 pts; pós-MVP explícito no Backlog |
| Sprint de 1 semana com feriados | Médio | Buffer na Sprint 3; daily assíncrono |
| Review atrasada (1 reviewer) | Médio | PRs pequenos (< 400 linhas); review em até 24 h |
| Ambiente Supabase compartilhado | Médio | Projeto Supabase de dev separado; migrations versionadas |
| Divergência entre app e Project | Baixo | `docs/plano/backlog.json` como fonte única; publicação idempotente |
