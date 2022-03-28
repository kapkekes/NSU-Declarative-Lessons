# Breadth First Search algorith

Package can be built using both **Stack** and **Cabal** on **Windows 11**.

Contains only one module - `Data.Graph.Search`, which implements BFS and some useful functions.

## How to build and run:
1. Download and unpack one of release archives.
2. Open Command Prompt or PowerShell (via <kbd>Win</kbd> + <kbd>R</kbd>, write `wt`, <kbd>Enter</kbd>).
3. Go to unpacked archive (`cd` for Command Prompt, `Set-Location` for PowerShell).
4. Build the project:
    1. For Stack:
    ```
    stack build
    ```
    1. For Cabal:
    ```
    cabal build
    ```
5. That's all!
6. P.S. if you use Stack, you can execute `stack ghci` and test all functionality of package.