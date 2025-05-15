# Flutter 项目结构设计规范（参考 codewithandrea 最佳实践）

> 参考文档：
> - [Flutter App Architecture with Riverpod: An Introduction](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)
> - [Flutter Project Structure: Feature-first or Layer-first?](https://codewithandrea.com/articles/flutter-project-structure/)
> - [Flutter App Architecture: The Repository Pattern](https://codewithandrea.com/articles/flutter-repository-pattern/)
> - [Flutter App Architecture: The Domain Model](https://codewithandrea.com/articles/flutter-app-architecture-domain-model/)
> - [Flutter App Architecture: The Application Layer](https://codewithandrea.com/articles/flutter-app-architecture-application-layer/)
> - [Flutter App Architecture: The Presentation Layer](https://codewithandrea.com/articles/flutter-presentation-layer/)

本规范基于 Andrea Bizzotto 的 Flutter 架构系列文章，旨在为 Flutter 项目提供一套清晰、可维护、易扩展的项目结构建议。本文档主要关注如何组织代码结构和分层架构，以确保代码易于理解、测试和维护。

## 核心原则

- **关注点分离（Separation of Concerns）**：每一层只关注自身职责，降低耦合。不同的组件应该有明确定义的职责，避免UI代码、业务逻辑和数据访问逻辑混在一起。
- **单向依赖**：依赖流动自上而下（表现层 → 应用层 → 领域层/数据层），避免循环依赖。上层可以依赖下层，但下层不应依赖上层。
- **可测试性**：各层职责清晰，便于单元测试和集成测试。模型类、服务和仓库应易于测试，不需要复杂的模拟设置。
- **灵活调整**：结构可根据项目实际需求和团队习惯适当调整，但应保持核心架构原则不变。
- **领域模型优先**：从领域模型出发设计应用，确保业务逻辑在领域层中正确表达，而不是分散在整个应用中。

## 分层架构

推荐采用经典的分层架构，将应用划分为四个主要层次，每层有明确的职责和边界：

![Flutter分层架构](https://codewithandrea.com/articles/flutter-app-architecture-domain-model/images/flutter-app-architecture.webp)

- **表现层 (Presentation Layer)**：负责 UI、用户交互和状态管理。包含小部件、控制器（或视图模型）和屏幕。
- **应用层 (Application Layer)**：处理应用用例和业务流程，协调领域层和数据层。包含服务类，可以作为控制器和仓库之间的中间人。
- **领域层 (Domain Layer)**：定义核心业务逻辑和领域模型，表达业务概念和规则。
- **数据层 (Data Layer)**：负责数据操作，包括数据仓库、数据源和DTO（数据传输对象），处理数据持久化和检索。

这种分层架构的主要优势在于明确的关注点分离、清晰的依赖方向（自上而下），以及更好的可测试性。

## 项目结构选择：特性优先 vs 层优先

在构建 Flutter 应用时，主要有两种组织项目结构的方法：

### 1. 层优先 (Layer-first)

层优先方法将项目按架构层次进行组织，每个层中包含不同的功能：

```
lib/
└── src/
    ├── presentation/
    │   ├── feature1/
    │   └── feature2/
    ├── application/
    │   ├── feature1/
    │   └── feature2/
    ├── domain/
    │   ├── feature1/
    │   └── feature2/
    ├── data/
    │   ├── feature1/
    │   └── feature2/
    └── ...
```

**优点**：易于理解层次结构
**缺点**：相关功能的代码分散在不同文件夹，难以维护和扩展

### 2. 特性优先 (Feature-first)

特性优先方法围绕功能特性组织项目，每个特性包含所有相关层：

```
lib/
└── src/
    ├── features/
    │   ├── feature1/
    │   │   ├── presentation/
    │   │   ├── application/
    │   │   ├── domain/
    │   │   └── data/
    │   └── feature2/
    │       ├── presentation/
    │       ├── application/
    │       └── ...
    └── ...
```

**优点**：相关代码放在一起，易于维护和扩展
**缺点**：需要明确定义"特性"的边界

### 推荐使用特性优先 + 分层结构

特性优先方法更适合中大型应用，因为它能更好地隔离功能，便于团队协作和代码维护。推荐的项目结构如下：

```
lib/
└── src/
    ├── features/ # 功能模块
    │   ├── authentication/ # 认证功能
    │   │   ├── presentation/
    │   │   │   ├── widgets/ # 特定于此功能的小部件
    │   │   │   ├── controllers/ # 控制器或视图模型
    │   │   │   └── screens/ # 页面
    │   │   ├── application/
    │   │   │   └── services/ # 业务服务
    │   │   ├── domain/
    │   │   │   └── models/ # 领域模型
    │   │   └── data/
    │   │       ├── repositories/ # 仓库实现
    │   │       └── data_sources/ # 远程或本地数据源
    │   ├── products/
    │   │   ├── presentation/
    │   │   ├── application/
    │   │   ├── domain/
    │   │   └── data/
    │   └── ...
    ├── common_widgets/ # 可复用的通用小部件
    ├── constants/ # 应用常量
    ├── exceptions/ # 自定义异常类
    ├── localization/ # 国际化资源
    ├── routing/ # 路由定义
    ├── utils/ # 通用工具函数
    ├── app.dart # 应用入口
    └── ... # 其他公共代码
main.dart
```

### 各层职责说明

#### 1. 表现层 (Presentation Layer)
- 负责 UI 渲染、用户交互、状态管理。
- 包含：
  - **Widgets**：UI 组件。
  - **Controllers/ViewModels**：管理状态、处理用户输入，与应用层或数据层交互。
  - **Screens/Pages**：顶级页面组件。
- 依赖：可依赖应用层和领域层。

#### 2. 应用层 (Application Layer)
- 负责编排领域对象，处理应用用例。
- 包含：
  - **Services**：封装应用场景逻辑，协调多个仓库或领域对象。
- 依赖：领域层、数据层。
- 说明：如无复杂业务流程，可省略应用层，控制器可直接调用仓库。

#### 3. 领域层 (Domain Layer)
- 负责核心业务逻辑和规则。
- 包含：
  - **Models/Entities**：业务模型，包含业务逻辑。
  - **Value Objects**：值对象，如 Email、Money。
  - **(可选) Domain Services**：不适合放在实体中的业务逻辑。
- 依赖：不依赖其他层。

#### 4. 数据层 (Data Layer)
- 负责数据持久化、检索。
- 包含：
  - **Repositories**：定义数据操作契约（接口/抽象类），实现与数据源的解耦。
  - **Data Sources**：与外部数据源（API、数据库等）交互。
  - **DTOs**：数据传输对象，负责序列化/反序列化。
- 依赖：可依赖外部库和领域层模型。

## 仓库模式（Repository Pattern）

- 目的：隔离领域模型与数据源实现细节，将外部数据转换为领域实体。
- 实现：
  - 定义抽象仓库接口（如 `abstract class WeatherRepository`）。
  - 实现具体仓库类（如 `class HttpWeatherRepository implements WeatherRepository`），依赖具体数据源。
- 优点：
  - 第三方 API 变更时只需更新仓库实现。
  - 易于测试，可通过 mock 仓库或数据源进行单元测试。
- 关于抽象类：Dart 所有类都有隐式接口，只有一个实现时可直接用具体类。

## 测试（Testing）

- `test/` 目录结构应与 `lib/` 保持一致。
- **单元测试**：
  - 领域层模型和业务逻辑。
  - 应用层服务。
  - 数据层仓库（可 mock 数据源）。
  - 表现层控制器（可 mock 依赖服务或仓库）。
- **Widget 测试**：测试 UI 组件渲染和交互。
- **集成测试**：测试多个组件或层之间的协作。

## 总结

采用 feature-first 结构和分层架构，有助于构建可扩展、可维护的 Flutter 应用。理解各层职责，保持依赖单向流动。结构可根据实际需求灵活调整，建议定期回顾和优化项目结构。

本规范可根据团队实际情况持续完善。
