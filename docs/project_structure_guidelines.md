# Flutter 项目结构设计规范（参考 codewithandrea 最佳实践）

> 参考文档：
> - [Flutter App Architecture with Riverpod: An Introduction](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)
> - [Flutter Project Structure: Feature-first or Layer-first?](https://codewithandrea.com/articles/flutter-project-structure/)
> - [Flutter App Architecture: The Repository Pattern](https://codewithandrea.com/articles/flutter-repository-pattern/)
> - [Flutter App Architecture: The Domain Model](https://codewithandrea.com/articles/flutter-app-architecture-domain-model/)
> - [Flutter App Architecture: The Application Layer](https://codewithandrea.com/articles/flutter-app-architecture-application-layer/)
> - [Flutter App Architecture: The Presentation Layer](https://codewithandrea.com/articles/flutter-presentation-layer/)
> - [Scripts for Building a Riverpod Clean Architecture Feature Generator for Flutter Projects](https://medium.com/@nahroaso100/scripts-for-building-a-riverpod-clean-architecture-feature-generator-for-flutter-projects-d5551f6fcf5a)

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

### 推荐使用特性优先 + Riverpod Clean Architecture 结构

特性优先方法更适合中大型应用，因为它能更好地隔离功能，便于团队协作和代码维护。结合Riverpod状态管理，推荐的项目结构如下：

```
lib/
└── src/
    ├── features/ # 功能模块
    │   ├── authentication/ # 认证功能
    │   │   ├── presentation/
    │   │   │   ├── widgets/ # 特定于此功能的小部件
    │   │   │   ├── pages/ # 页面组件
    │   │   │   └── providers/ # Riverpod providers
    │   │   ├── domain/
    │   │   │   ├── entities/ # 领域实体
    │   │   │   ├── repositories/ # 抽象仓库接口
    │   │   │   └── usecases/ # 用例实现 - 业务逻辑
    │   │   └── data/
    │   │       ├── repositories/ # 仓库实现
    │   │       ├── datasources/ # 远程或本地数据源
    │   │       └── models/ # 数据模型 (DTOs)
    │   ├── products/
    │   │   ├── presentation/
    │   │   ├── domain/
    │   │   └── data/
    │   └── ...
    ├── core/ # 核心功能和通用代码
    │   ├── api/ # API客户端和网络相关
    │   ├── theme/ # 应用主题
    │   ├── enums/ # 全局枚举
    │   ├── errors/ # 错误处理
    │   ├── utils/ # 通用工具函数
    │   ├── constants/ # 应用常量
    │   ├── routes/ # 路由定义
    │   ├── extensions/ # Dart扩展方法
    │   └── widgets/ # 可复用的通用小部件
    ├── app.dart # 应用入口
    └── injector.dart # 依赖注入设置
main.dart
```

### 与传统分层架构的主要区别

此结构基于Clean Architecture并针对Riverpod进行了优化：

1. **移除了应用层**：用例(Usecases)直接在domain层中实现，简化了架构
2. **Providers作为粘合剂**：Riverpod providers负责连接UI和业务逻辑
3. **更精简的领域层**：包含entities、repositories接口和usecases
4. **核心模块集中化**：通用功能统一放在core目录下

### 各层职责说明

#### 1. 表现层 (Presentation Layer)
- **Pages**：完整的页面组件
- **Widgets**：特定功能的UI组件
- **Providers**：
  - 状态管理 (StateNotifierProvider, StateProvider等)
  - 连接UI与用例 (UseCases)
  - 处理状态转换并提供给UI消费

#### 2. 领域层 (Domain Layer)
- **Entities**：纯粹的业务对象，不依赖于数据层
- **Repositories**：定义数据操作的抽象接口
- **UseCases**：封装单一业务逻辑或流程，每个用例处理特定业务场景

#### 3. 数据层 (Data Layer)
- **Models**：数据传输对象(DTOs)，用于序列化/反序列化
- **Repositories实现**：实现领域层定义的仓库接口
- **DataSources**：处理具体数据源(API、本地数据库等)

#### 4. 核心层 (Core)
- 包含跨功能的通用代码，如导航、主题、工具函数等
- 所有功能模块都可以依赖此层

## Riverpod与Clean Architecture的结合

Riverpod提供了灵活的状态管理方案，便于实现Clean Architecture:

- **Providers作为用例的入口点**：表现层通过Provider调用用例
- **StateNotifierProvider**：管理复杂状态，如API调用的加载/成功/错误状态
- **Provider依赖注入**：通过ref轻松注入仓库和服务
- **Immutable State**：状态不可变，通过state类表示不同状态

## 功能生成建议

考虑使用脚本或工具(如riverpod_clean_arch_generator)自动生成符合此结构的功能模板：

- 一键创建完整的feature目录结构
- 自动生成必要的state类、providers、repositories和usecases
- 确保一致的代码组织和命名约定

通过此结构，可以充分利用Riverpod的灵活性和Clean Architecture的可测试性与可维护性。

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
