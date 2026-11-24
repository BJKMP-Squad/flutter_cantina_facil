# 01 — Visão do Produto e Escopo (Rodada 1)

> **Projeto:** Cantina Fácil · **Atualizado:** 2026-11-10 · **Status:** Rodada 1 concluída — aguardando gate para Rodada 2

## 1. Visão do produto

Para **pais e responsáveis que precisam controlar o consumo dos filhos na cantina escolar** e para **operadores que precisam registrar vendas com agilidade no balcão**, o **Cantina Fácil** é um **aplicativo Flutter de cantina digital com carteira pré-paga por aluno** que **centraliza recarga de crédito, venda no PDV e transparência de gastos em tempo real**. Diferente de cartões físicos, fichas de papel e planilhas, ele **permite que o operador debite o saldo do aluno em segundos e que o responsável acompanhe cada movimentação em tempo real, com perfis e permissões separados no Supabase**.

## 2. Personas

### P1 — Operador de PDV (funcionário da cantina)

- **Objetivo:** atender a fila do intervalo rápido, registrar a venda sem erro e nunca deixar o saldo inconsistente.
- **Contexto:** balcão da cantina, picos de movimento, uso em pé, celular/tablet Android; aluno informa nome ou matrícula.
- **Frustração:** sistemas lentos, busca de aluno confusa, saldo insuficiente descoberto no fim da venda, retrabalho para corrigir lançamento errado.

### P2 — Pai/Responsável

- **Objetivo:** manter crédito no saldo do filho, saber quanto e onde ele gastou e ser avisado quando o saldo estiver baixo.
- **Contexto:** celular Android, rotina corrida, pode ter mais de um filho na escola; recarga feita presencialmente na cantina no MVP.
- **Frustração:** não saber quanto o filho gastou, depender de dinheiro em espécie, falta de comprovante/transparência e medo de gasto excessivo.

### P3 — Gestor da cantina (dono/coordenador)

- **Objetivo:** manter catálogo, preços e disponibilidade atualizados, acompanhar vendas e operar recargas com segurança.
- **Contexto:** gestão do negócio, acesso ao app Flutter no mesmo dispositivo ou em outro; responde por erros de caixa.
- **Frustração:** planilhas manuais, falta de visão de vendas do dia, retrabalho para corrigir lançamentos e produtos sem foto/preço correto.

## 3. Jornada principal (10 passos)

1. O pai instala o app, cria a conta e vincula o(s) filho(s) informando a matrícula (vínculo aprovado pelo gestor/operador).
2. O pai vai à cantina e paga a recarga em dinheiro/cartão.
3. O operador localiza o aluno e lança o crédito; o sistema registra a recarga com comprovante.
4. O pai vê o saldo atualizado em tempo real e a recarga no extrato.
5. No intervalo, o aluno vai ao balcão e pede os itens.
6. O operador busca o aluno no PDV por nome/matrícula.
7. O operador adiciona os produtos ao carrinho e confere o total.
8. O operador confirma a venda; o sistema valida o saldo e debita em transação atômica.
9. O operador entrega os produtos; o pai recebe a atualização do saldo e vê a venda no extrato em tempo real.
10. O gestor acompanha as vendas do dia e mantém produtos, preços e imagens atualizados.

## 4. Escopo MoSCoW

### Must (MVP)

- Autenticação e perfis (Operador PDV, Pai/Responsável, Gestor) via Supabase Auth + tabela `profiles` com `role`.
- Vínculo pai ↔ aluno por matrícula, com aprovação do gestor/operador.
- Recarga de crédito lançada pelo operador, com registro auditável.
- Venda no PDV: busca de aluno por nome/matrícula, catálogo, carrinho e débito atômico de crédito.
- Saldo e extrato por aluno visíveis para pai (somente seus filhos) e operador/gestor.
- CRUD de produtos e categorias com imagem no Supabase Storage.
- Atualização em tempo real de saldo e vendas (Supabase Realtime).
- RLS: pai acessa apenas seus alunos; operador opera vendas/recargas; gestor gerencia catálogo e usuários.

### Should

- Estorno/cancelamento de venda com trilha de auditoria e permissão do gestor.
- Relatório básico de vendas do dia (por produto/operador).
- Alerta/limite de gasto por aluno (definir regra com o gestor).
- Extrato filtrável por período e tipo de movimentação.

### Could

- Notificações push (saldo baixo, compra realizada).
- QR Code do aluno como alternativa à busca por matrícula.
- Recarga via Pix automático (PSP + webhook).
- Impressão de recibo no PDV.
- Leitura offline com sincronização posterior.

### Won't (neste ciclo)

- Backoffice web.
- App próprio do aluno.
- Pagamento direto pelo aluno (Pix/cartão no app do aluno).
- Fidelidade, cupons e integração com catraca/estoque avançado.

## 5. Decisões da Rodada 1

| # | Pergunta | Resposta |
|---|---|---|
| P1 | Identificação do aluno no PDV | **(b)** Busca por nome/matrícula digitada pelo operador |
| P2 | Recarga de crédito | **(b)** Presencial: operador lança o crédito após receber dinheiro/cartão |
| P3 | Perfil de gestão | **(b)** 3º perfil "Gestor" explícito no app Flutter |
| P4 | Obrigatório no MVP | **(a)** Venda PDV + débito de crédito + saldo/extrato dos pais + CRUD de produtos com imagem + realtime |
| P5 | Prazo/requisito acadêmico | **3 sprints de 1 semana** (datas e rubrica a confirmar na Rodada 3) |

## 6. Premissas e restrições

**Premissas**

- [SUPOSIÇÃO] Um responsável pode ter **N alunos**; o saldo é **por aluno**.
- [SUPOSIÇÃO] Alunos **não usam o app** neste ciclo; a compra é feita presencialmente pelo operador.
- [SUPOSIÇÃO] Recarga presencial é suficiente no MVP; Pix automático fica para pós-MVP.
- [SUPOSIÇÃO] O Figma é referência visual; as especificações das telas serão descritas/nomeadas pelo responsável durante as rodadas.
- Supabase será o backend único (Auth, Postgres + RLS, Storage, Realtime).
- Riverpod com annotations + Clean Architecture (feature-first) conforme padrão do projeto.

**Restrições**

- Entrega acadêmica em **3 sprints de 1 semana** (capacidade e calendário na Rodada 3).
- Sem backoffice web: operação e gestão acontecem no app Flutter.
- Projeto Supabase novo; plano gratuito deve suportar o MVP.
- Dados de menores: minimização obrigatória (LGPD).

## 7. Riscos e mitigação

| # | Risco | Impacto | Mitigação |
|---|---|---|---|
| R1 | Débito duplo ou saldo negativo por vendas concorrentes | Alto — dinheiro errado e perda de confiança | Débito via função Postgres (RPC) atômica com verificação de saldo; testes de concorrência |
| R2 | Erro operacional (aluno errado, recarga errada) | Alto — prejuízo ao caixa | Confirmação com nome + turma/matrícula; log de auditoria; estorno com permissão do gestor |
| R3 | LGPD / dados de menores | Alto — risco legal e institucional | Coletar o mínimo (nome, matrícula, turma), consentimento dos pais, RLS restritiva, política de retenção |
| R4 | Conectividade instável no balcão | Médio — fila parada | Cache de leitura, retry com feedback claro; fallback manual documentado |
| R5 | Prazo curto (3 sprints) | Médio — entrega incompleta | MVP enxuto (Must acima), pós-MVP explícito, buffer na Sprint 3 |
| R6 | Curva de aprendizado Supabase/RLS | Médio — atraso na fundação | Spike de RLS e Realtime na Sprint 1; policies testadas antes das telas |
| R7 | Custo/limites do Realtime | Baixo — degradação | Canais por aluno e por cantina, unsubscribe ao sair da tela |

## 8. Métricas de sucesso

- **Tempo médio de venda no PDV** ≤ 30 s (p95) do início da busca ao débito confirmado.
- **Taxa de vendas com erro/estorno** < 1% das transações.
- **Recargas conciliadas** = 100% (nenhuma divergência de caixa no fechamento do dia).
- **Adoção dos pais**: ≥ 70% dos responsáveis consultando saldo/extrato semanalmente.
- **Estabilidade**: crash-free sessions > 99% e zero saldo negativo após concorrência.
