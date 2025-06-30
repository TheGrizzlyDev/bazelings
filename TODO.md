# TODO List for Bazelings

## Curriculum - Next Chapters and Lessons

This section outlines the planned future chapters and their core content to expand the Bazelings learning experience.

### Chapter 02: Advanced Starlark & Custom Rules
- **Why this chapter?** Building on the "little Starlark" introduction, this chapter would empower users to extend Bazel's capabilities by writing their own build rules, which is essential for handling unique project requirements or integrating niche tools.
- **Content:**
    - `rule()` function: Defining custom rules.
    - `attr` types: Understanding and using different attribute types (e.g., `label`, `label_list`, `string`, `int`, `bool`, `dict`).
    - `ctx` object: Interacting with the build environment (e.g., accessing attributes, creating actions).
    - Actions: Creating build actions (`ctx.actions.run`, `ctx.actions.write`).
    - Providers: Passing information between rules (e.g., `DefaultInfo`, custom providers).
    - Simple Custom Rule Example: A step-by-step guide to creating a basic custom rule (e.g., a rule that generates a file based on some input, or a simple code generator).

### Chapter 03: External Dependencies
- **Why this chapter?** Real-world projects rarely exist in isolation. This chapter would teach users how to integrate third-party libraries and tools into their Bazel builds, a fundamental skill for any non-trivial project.
- **Content:**
    - `MODULE.bazel` and Bzlmod: Deep dive into Bazel's modern dependency management system.
        - `bazel_dep`: Declaring external module dependencies.
        - `use_repo`: Making repositories from external modules available.
        - `http_archive`: Fetching remote archives (e.g., pre-built libraries, toolchains).
        - `local_path`: Referencing local directories as external repositories (useful for development/testing).
    - Transitive Dependencies: How Bazel handles dependencies of dependencies.
    - Vendoring (Optional): Briefly touch upon vendoring external dependencies for hermeticity.

### Chapter 04: Workspaces and Monorepos
- **Why this chapter?** As projects grow, managing multiple related components within a single repository (a monorepo) becomes common. This chapter would cover best practices for structuring and managing such setups with Bazel.
- **Content:**
    - Monorepo Structure: Recommended directory layouts for Bazel monorepos.
    - Visibility: Controlling access between targets in different packages.
    - Package Groups: Defining logical groups of packages for visibility control.
    - Cross-Package Dependencies: Best practices for referencing targets across different Bazel packages.
    - `WORKSPACE` (Legacy vs. Bzlmod): A more detailed comparison and migration path from the older `WORKSPACE` file to `MODULE.bazel`.

### Chapter 05: Toolchains and Platforms
- **Why this chapter?** For reproducible and cross-platform builds, understanding how Bazel selects and uses compilers, SDKs, and other tools is critical. This is a more advanced topic but crucial for robust build systems.
- **Content:**
    - Concept of Toolchains: What they are and why they are important for hermeticity and reproducibility.
    - `toolchain_type` and `toolchain` rules: Defining custom toolchains.
    - Platforms: Defining target and execution platforms.
    - Registering Toolchains: Making toolchains available to Bazel.
    - `target_compatible_with` and `exec_compatible_with`: Constraining rule execution based on platforms.

### Chapter 06: Performance and Debugging
- **Why this chapter?** Once users have a basic understanding of Bazel, they will inevitably encounter performance challenges or need to debug complex build issues. This chapter would provide practical techniques and tools.
- **Content:**
    - Build Profiling: Using `--profile` to identify bottlenecks in the build graph.
    - Remote Caching and Execution (Conceptual): Explain the benefits and basic setup (without requiring actual remote infrastructure).
    - Bazel Query Language: Using `bazel query` for analyzing the build graph and understanding dependencies.
    - Debugging Starlark: Techniques for debugging custom rules and macros (e.g., print statements, using `fail`).
    - Common Performance Pitfalls: Discussing common mistakes that lead to slow builds and how to avoid them.
