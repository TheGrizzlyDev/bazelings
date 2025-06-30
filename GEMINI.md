# GEMINI.md - Codebase Optimization Guidelines

## General Instructions

*   **Adhere to Existing Conventions:** Always prioritize and mimic existing code style, structure, and patterns found in the surrounding files.
*   **Focus on Exercises:** When working on exercises, prioritize completing the task as described in the `README.md` for that specific exercise. Avoid making changes beyond the scope of the exercise unless explicitly requested.
*   **Test-Driven Development:** When implementing solutions for exercises, assume that the provided `unittest` or `diff_test` assertions are the primary verification mechanism. Aim to make these tests pass.

## Preferred Tools and Commands

*   **Bazel Execution:**
    *   Attempt to use `bazel` for commands first.
    *   If `bazel` is not found or fails, use `bazelisk` as a fallback.
    *   The primary test command for exercises is `bazelisk test //exercises:<lesson_name>_test`.

## Project Context

*   **Learning Resource:** This repository is designed as a learning resource for Bazel. Solutions should be clear, concise, and directly address the exercise's objective.
*   **Starlark Files (`.bzl`):** When modifying or creating `.bzl` files, ensure that Starlark syntax is strictly followed. Pay close attention to indentation and function definitions.
