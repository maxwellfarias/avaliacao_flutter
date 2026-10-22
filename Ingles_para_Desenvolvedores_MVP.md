# Aplicativo de inglês — especificação do MVP

> **Limite de cobertura:** consolidação das mensagens disponíveis, do trecho 167 ao 261, complementadas por informações recuperadas da mesma conversa. O início não foi recuperado integralmente. Este documento não representa uma auditoria completa de todo o histórico. As lacunas de confirmação estão identificadas.
>
> **Uso na implementação:** implementar decisões confirmadas; tratar propostas como alternativas ainda não autorizadas; resolver pontos em aberto antes de definir comportamentos dependentes deles. Os critérios de verificação abaixo traduzem as decisões em comportamentos observáveis, sem acrescentar funcionalidades.

**Status utilizados:**

- **Decisão confirmada:** instrução ou aprovação do usuário verificável no histórico disponível ou recuperado.
- **Proposta ainda não aprovada:** sugestão do assistente sem aprovação verificável.
- **Ponto em aberto:** detalhe não definido, conflito não resolvido ou confirmação original indisponível.

## 1. Objetivo e público-alvo

**Decisão confirmada — contexto recuperado da mesma conversa.**

- Curso de **Inglês para Desenvolvedores**, inicialmente para alunos de nível intermediário.
- As **12 unidades constituem o curso completo**.
- Pretende-se reutilizar a interface e os componentes Flutter para outras trilhas, alterando o conteúdo.
- A implementação deve se limitar ao módulo discutido nesta conversa. Ideias anteriores de geração dinâmica de conteúdo e aprendizagem adaptativa não integram automaticamente este escopo.

**Ponto em aberto — recorte de lançamento:** foi recuperada uma referência do assistente a um MVP com unidades 1–3, mas não a aprovação correspondente. **A definir:** quantas das 12 unidades estarão disponíveis no lançamento.

## 2. Escopo e funcionalidades do MVP

| Funcionalidade | Status | Definição |
| --- | --- | --- |
| Curso com 12 unidades | Decisão confirmada | Estrutura do curso completo; recorte inicial a definir |
| Caminho com lições e atividades | Decisão confirmada no contexto recuperado | Detalhamento dos tipos de etapa ainda incompleto |
| Diálogos em tela única | Decisão confirmada | Opções de áudio, texto e tradução |
| Pronúncia guiada | Decisão confirmada | Frase de referência e avaliação pelo Azure Speech |
| Revisões com FSRS | Decisão confirmada | Entrada por erro na primeira tentativa |
| Área Praticar | Decisão confirmada | Acesso às revisões pendentes |
| XP, ofensiva e celebração de conclusão | Decisão confirmada | Gamificação simples |
| Metas configuráveis e lembretes | Decisão confirmada | Três intensidades de meta e notificações limitadas |
| Progresso distribuído entre início e perfil | Decisão confirmada | Sem página aprofundada de estatísticas por unidade |

**Decisão confirmada — contexto recuperado:** prática e revisão ilimitadas, sem corações ou paywalls. A avaliação de voz depende de integração externa; limites técnicos, disponibilidade e custos não foram transformados em regras de bloqueio ao aluno.

## 3. Jornada e navegação do aluno

**Decisão confirmada.**

1. O aluno acompanha o caminho de aprendizagem na tela inicial.
2. Acessa atividades e diálogos do curso.
3. Nos diálogos, escolhe a forma de apresentação.
4. Nos exercícios de pronúncia, lê ou ouve a frase e grava sua tentativa.
5. Consulta a quantidade de revisões pendentes e usa **Revisar agora** para abrir **Praticar**.
6. Continua avançando no curso sem obrigação de zerar as revisões.
7. Consulta histórico, metas e progresso geral pelo perfil.

Na tela inicial, ficam visíveis o caminho, XP diário, ofensiva e revisões pendentes. Dentro das unidades, aparecem os estados de conclusão das etapas.

**Ponto em aberto:** regras exatas de desbloqueio, retomada de sessão incompleta e comportamento quando não houver revisões pendentes.

**Verificação:** abrir Praticar pelo destaque inicial deve levar às mesmas revisões disponíveis nessa área; revisões pendentes não podem bloquear o avanço por si só.

## 4. Regras de negócio por funcionalidade

### 4.1. Respostas e correção

**Decisão confirmada — contexto recuperado:**

- Ao errar, o aluno recebe a resposta correta e uma explicação.
- O item errado retorna ao fim da sessão.
- Exercícios de digitação aceitam respostas alternativas.

**Ponto em aberto:** quais alternativas são aceitas e como serão representadas ou comparadas.

**Ponto em aberto — conclusão:** o assistente recapitulou que uma etapa só termina após todos os itens serem respondidos corretamente, com correção dos erros. A aprovação original não está disponível. Confirmar essa regra antes de aplicá-la a todos os tipos de atividade, especialmente pronúncia.

**Verificação das regras confirmadas:** uma resposta incorreta apresenta correção e explicação, e o item reaparece ao fim. Respostas alternativas previamente definidas como válidas devem ser aceitas.

### 4.2. Registro das tentativas

**Decisão confirmada:** registrar acertos e erros no Supabase para permitir análise posterior.

O registro precisa preservar a distinção entre erro na primeira tentativa e acerto após correção, pois a entrada no FSRS depende dela. Isso é uma necessidade da regra, não uma definição de esquema de banco.

**Ponto em aberto:** granularidade dos registros, retomada de sessão e demais detalhes de persistência.

### 4.3. Dependências

- Revisões dependem do resultado da primeira tentativa.
- XP depende da conclusão da sessão.
- Ofensiva depende de concluir uma sessão no dia.
- Meta diária depende do XP obtido naquele dia.
- Notificações dependem da meta diária e das revisões pendentes.
- Pronúncia depende de texto de referência, gravação e avaliação de voz.

## 5. Conteúdo, exercícios e diálogos

### 5.1. Organização do conteúdo

**Decisão confirmada — documentação do usuário recuperada:**

- Cada unidade segue: situação → dois diálogos → vocabulário/frases → gramática → exercícios → áudio → revisão.
- O caminho menciona lições, diálogos, baú, escuta/pronúncia, tarefa real e revisão.
- O conteúdo é original, inspirado apenas na ordem gramatical do English File.

**Ponto em aberto:** funcionamento de baús, tarefas reais e relação exata entre essa organização inicial e as telas posteriormente consolidadas. A mera menção não define recompensas ou regras próprias.

**Ponto em aberto — tamanho das sessões:** a documentação inicial menciona 10–15 itens; uma recapitulação posterior do assistente fala em sessões curtas sem limite artificial de quantidade. A confirmação dessa alteração não foi recuperada. **A definir:** regra final; não codificar um limite como decisão consolidada.

**Ponto em aberto:** catálogo completo de tipos de exercício e regras específicas de cada tipo.

### 5.2. Diálogos em tela única

**Decisão confirmada:** centralizar a experiência, permitindo:

- somente áudio;
- áudio com texto;
- áudio com texto e tradução.

A proposta de criar um fluxo separado de “Só Ouvir” foi substituída pela tela única.

**Proposta ainda não aprovada de forma verificável:**

- destacar a fala atual e rolar o texto durante o áudio;
- repetir falas, pausar e ajustar a velocidade;
- apresentar perguntas apenas ao final;
- não medir listening separadamente.

Esses detalhes aparecem na consolidação do assistente; sua confirmação específica não está disponível no trecho recuperado.

**Verificação:** o mesmo diálogo pode ser apresentado nas três modalidades sem exigir atividades independentes. O modo somente áudio oculta o texto.

## 6. Revisões e repetição espaçada

**Decisão confirmada.**

- Somente exercícios errados na **primeira tentativa** entram automaticamente no FSRS.
- Acertar depois da correção não desfaz essa entrada.
- Depois de incluído, o exercício continua nas revisões mesmo quando o aluno passa a acertá-lo; os intervalos aumentam conforme o agendamento.
- A tela inicial informa quantas revisões estão pendentes.
- **Revisar agora** abre a área **Praticar**.
- Revisar não é pré-requisito para continuar as unidades.
- Acertos e erros ficam registrados no Supabase.

A seleção dos exercícios e o agendamento são responsabilidades distintas: a regra de erro seleciona; o FSRS agenda.

**Ponto em aberto:** o uso exclusivo de `good` e `again` aparece em recapitulação do assistente, sem aprovação original recuperada. Confirmar os resultados utilizados e seu mapeamento.

**Pontos em aberto:**

- tamanho e conclusão de uma sessão de revisão;
- tratamento de revisões atrasadas;
- significado de “primeira tentativa” ao refazer uma atividade;
- elegibilidade de pronúncia e outros tipos de exercício;
- relação entre correção imediata e atualização do FSRS;
- experiência quando a fila estiver vazia.

**Verificação:** erro inicial seguido de acerto mantém o item elegível; acerto inicial não gera inclusão automática; pendências não bloqueiam o curso.

## 7. Pronúncia e integração de voz

**Decisão confirmada.**

- Integrar **Azure Speech Pronunciation Assessment** ao MVP.
- Usar frases específicas, com pronúncia guiada.
- Oferecer **ouvir e repetir** e **ler e falar**.
- Em ler e falar, manter o áudio disponível como ajuda.
- A abordagem aprovada propõe ouvir e repetir inicialmente e ler e falar depois, com ler e falar como padrão.
- Permitir ouvir novamente e repetir a tentativa.
- Dar feedback sobre palavras que merecem atenção.
- Priorizar fala compreensível, sem exigir eliminação do sotaque brasileiro.

O usuário escolheu o serviço para que o aluno praticando sozinho tenha retorno sobre sua pronúncia.

**Proposta ainda não aprovada em seus detalhes técnicos:**

1. Flutter grava o áudio.
2. Uma Supabase Edge Function recebe a solicitação e encaminha áudio e referência ao Azure.
3. O resultado é interpretado e devolvido ao aplicativo.
4. A tentativa é registrada no Supabase.
5. A credencial permanece no servidor.

**Pontos em aberto:**

- critérios de aprovação e de conclusão;
- quantidade de tentativas e possibilidade de prosseguir;
- apresentação exata de omissões, adições e problemas de pronúncia;
- calibração das pontuações com brasileiros;
- tratamento de silêncio, ruído, falha de reconhecimento e indisponibilidade;
- retenção ou descarte das gravações;
- limites e custos efetivos do plano escolhido.

A conversa apresentou capacidades e franquias do provedor, mas não as validou como contrato técnico definitivo. Não assumir que toda avaliação é gratuita nem que a API garante neutralidade em relação a sotaques.

**Verificação:** o aluno pode gravar em ambas as modalidades, consultar feedback e tentar novamente. Aprovação automática fica dependente da definição dos critérios.

## 8. Progressão, XP, ofensiva, metas e notificações

### 8.1. XP e celebração

**Decisão confirmada:** conceder uma quantidade fixa de XP por sessão concluída e apresentar animações simples de conclusão.

**Ponto em aberto:** valor do XP; quais sessões geram pontos; tratamento de sessões refeitas e revisões.

### 8.2. Ofensiva

**Decisão confirmada:** concluir uma sessão no dia mantém a ofensiva, independentemente de atingir a meta diária de XP. Essa decisão substitui a proposta anterior de vincular a ofensiva ao cumprimento da meta.

**Proposta ainda não aprovada de forma verificável:** zerar a sequência após um dia sem estudo e não oferecer congelamento no MVP.

**Ponto em aberto:** fuso horário, virada do dia e quais modalidades contam como sessão válida.

**Verificação:** uma sessão concluída preserva a ofensiva mesmo quando a meta escolhida exige mais XP.

### 8.3. Metas diárias

**Decisão confirmada:** o aluno escolhe entre três intensidades: leve, moderada e intensa, expressas em XP por dia.

**Ponto em aberto:** valores exatos. 10, 20 e 30 XP foram exemplos, não valores inequivocamente aprovados. Também falta definir o efeito de alterar a meta durante o dia.

### 8.4. Notificações

**Decisão confirmada:**

- lembrar de estudar perto do fim do dia se a meta ainda não foi atingida;
- avisar sobre revisões pendentes;
- limitar os avisos para evitar excesso.

**Ponto em aberto:** horários, frequência máxima, preferências, permissões e combinação de avisos coincidentes.

**Verificação:** o lembrete de meta considera a meta escolhida e seu cumprimento; o aviso de revisão depende de pendências. Não assumir uma quantidade diária de notificações.

## 9. Painel de progresso

**Decisão confirmada:** distribuir informações entre tela inicial, unidades e perfil, sem criar páginas aprofundadas de estatísticas individuais por unidade.

| Local | Informação |
| --- | --- |
| Tela inicial | Caminho, unidades concluídas/atual/próximas, XP diário, ofensiva e revisões pendentes |
| Unidade | Etapas concluídas |
| Perfil | Histórico de estudos, metas e progresso geral |

**Proposta ainda não aprovada nos detalhes:** percentual calculado por etapas obrigatórias, XP total, calendário, contagem de revisões recentes e histórico de sessões por dia.

**Ponto em aberto:** composição final do perfil e fórmulas dos indicadores.

**Verificação:** os estados de conclusão refletem o progresso registrado; meta e ofensiva são exibidas como conceitos independentes.

## 10. Dados e integrações mencionados

| Tecnologia ou dado | Status | Papel discutido |
| --- | --- | --- |
| Flutter | Decisão confirmada no contexto recuperado | Interface e componentes reutilizáveis |
| Supabase | Decisão confirmada para acertos e erros | Registro das tentativas |
| Supabase para conteúdo e retomada | Ponto em aberto quanto à confirmação original | Mencionado nas recapitulações do assistente |
| FSRS | Decisão confirmada | Agendamento das revisões selecionadas |
| Azure Speech Pronunciation Assessment | Decisão confirmada | Avaliação dos exercícios de pronúncia guiada |
| Supabase Edge Functions | Proposta ainda não aprovada | Intermediação da integração de voz |

Os conceitos discutidos incluem unidades, etapas, exercícios, respostas, tentativas, diálogos, textos de referência, áudio, revisões, sessões, XP, meta e ofensiva. **Não constituem um esquema de banco aprovado.**

**Pontos em aberto:** modelagem, autenticação, permissões, armazenamento de áudio e fluxo administrativo de cadastro/publicação de conteúdo.

## 11. Funcionalidades adiadas para fases futuras

**Decisão confirmada:**

- **Role-play com respostas livres:** aluno formula respostas próprias e o sistema interpreta e continua a conversa.
- **Rankings.**
- **Ligas competitivas.**
- **Moedas virtuais.**

Não há detalhamento aprovado dessas funcionalidades para implementação agora.

**Restrição de escopo confirmada no contexto recuperado:** geração dinâmica e o projeto adaptativo de conversas anteriores não devem ser incorporados ao módulo. Isso não equivale a um compromisso de implementá-los em uma fase futura.

## 12. Decisões ainda em aberto

Antes de implementar comportamentos dependentes, resolver:

1. Quantas das 12 unidades estarão no lançamento.
2. Quantidade de itens por sessão e divergência entre a documentação inicial e a recapitulação posterior.
3. Regra final de conclusão das etapas e desbloqueio das seguintes.
4. Tipos de exercício, alternativas aceitas e funcionamento de baús e tarefas reais.
5. Confirmação dos controles de áudio, destaque de falas e perguntas ao final dos diálogos.
6. Critérios de aprovação da pronúncia e efeito de falhas técnicas.
7. Mapeamento de resultados para o FSRS e tratamento de correções imediatas.
8. Regras de sessão de revisão, fila vazia e exercícios refeitos.
9. Valores de XP e das metas; elegibilidade das sessões para pontos e ofensiva.
10. Fuso horário, quebra e eventual congelamento da ofensiva.
11. Frequência, horários e preferências de notificações.
12. Indicadores finais do perfil e respectivas fórmulas.
13. Persistência de conteúdo/progresso, retomada, modelagem e segurança.
14. Cadastro, edição e publicação do conteúdo.
15. Arquitetura final da integração Azure, franquia, custos e política de gravações.

**Orientação para quem implementar:** não preencher estas lacunas silenciosamente nem reintroduzir sugestões antigas como requisitos. Utilizar as decisões confirmadas como base e manter os demais pontos explicitamente pendentes.

