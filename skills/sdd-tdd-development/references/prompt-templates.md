# Prompt Templates

## 1. New feature: spec first

```text
先不要写实现代码。

请基于这个需求先产出一份可在几分钟内审完的 spec，只写行为，不写实现偏好。

输出结构：
1. Goal
2. In scope
3. Out of scope
4. Inputs / outputs
5. Rules and validations
6. Edge cases
7. Error cases
8. Acceptance criteria

要求：
- 每条规则都必须能映射成测试、类型检查、schema 检查或人工 review 项
- 如果描述含糊，请改写成可验证表述
- spec 通过前，不要开始实现
```

## 2. Legacy code: read-only structure pass

```text
请只读这段遗留代码，不要修改任何文件。

请输出：
1. public API / 入口清单
2. 职责分块
3. 状态地图：数据库、全局变量、缓存、文件、事件
4. 可疑行为清单
5. 隐式耦合 / 副作用

目标不是立刻重构，而是先得到 current-state spec。
如果某个行为看起来像 bug，也先标记并锁定，不要顺手修。
```

## 3. Characterization tests before refactor

```text
基于这份 current-state spec，为现有行为补 characterization tests / feature tests。

要求：
- 先锁当前行为，再谈重构
- 覆盖 happy path、边界、异常、隐藏副作用
- 对可疑旧行为也先写成测试，避免重构时误改
- 在没有稳定测试网之前，不要改生产代码
```

## 4. RED -> GREEN loop

```text
先写失败测试并运行，确认 RED 是真实且与目标行为直接相关。

然后只做最小实现让测试转 GREEN。

限制：
- 不要扩大 scope
- 不要顺手重写无关模块
- 同一轮只解决当前失败信号
- GREEN 后再考虑重构
```

## 5. Structured failure feedback

```text
下面是失败证据。请只根据这些证据做最小修复，不要扩展范围。

Failed test: <test_name>
Input: <input>
Expected: <expected>
Actual: <actual>
Notes: <optional_hint>
```

## 6. GitHub issue -> PR execution

```text
请按这个 issue 工作：
1. 先复述目标、验收标准、不要动的范围
2. 给出最小计划
3. 先补 spec / 测试，后改实现
4. 保持小步提交
5. 本地运行与 CI 等价的关键检查
6. PR 里说明：哪些行为改变了，哪些行为被锁住但没修

不要自动扩大 scope。
不要把重构、bugfix、新功能混进同一个大 diff。
```

## 7. Contract propagation

```text
把这一层的机器可读契约当作下一层的 spec。

请检查：
1. 契约里有哪些 endpoint / schema / 字段 / 约束
2. 下游是否完全遵守
3. 是否有下游自己发明的字段或行为
4. 是否应该生成 typed client / mocks / validation
```

## 8. Multi-file structure mapping

```text
请只读这个目录，不要修改任何文件。

先输出三样东西：
1. 依赖图：谁 import 了谁，特别标出循环依赖
2. 状态图：数据库、模块级变量、缓存、配置、文件、事件、日志分别在哪里读写
3. 隐藏契约清单：public import 路径、下游直接触达内部模块的位置、事件/日志/审计格式

最后说明：
- 如果只改其中一个文件，最容易把哪里改坏
- 哪些地方必须先补 characterization tests 再动

先画图，不要给重构方案。
```

## 9. Spec to issue governance

```text
请把当前一次性的 spec 整理成可持续治理结构。

要求：
1. 给出 AGENTS.md 应写入的长期规则
2. 设计 spec/ 的状态结构：governance / planned / implemented / archived
3. 把当前 spec 拆成单条可维护 spec
4. 给现有 issue 分类：局部 bug / 设计变更 / 兼容性变更 / 同根因问题
5. 输出 PR 合并前的 spec 对账清单

先建治理结构，不要直接写业务实现。
```

## 10. GitHub AI pipeline

```text
请按 GitHub 协作管线执行：
1. 复述 issue 目标、验收标准、不要动的范围
2. 给出最小计划
3. 在独立分支上做小步修改
4. commit 保持可追踪
5. 运行本地等价 CI 检查
6. 如果失败，只根据日志做最小修复
7. PR 中写清：范围、验证、未改动范围、剩余风险

不要自动合并，不要扩大 scope。
```

## 11. Quality flywheel

```text
请按“生成 -> 验证 -> 修正”飞轮执行当前任务。

输出顺序：
1. 验证标准
2. 最小实现
3. 验证命令与关键结果
4. 若失败，按“失败项 / 输入 / 期望 / 实际 / 最小修复”分析
5. 修复后重新验证
6. 最终给出：改动范围、验证结果、剩余风险、需要人裁决的问题

不要跳过验证，不要把未验证内容说成已完成。
```
