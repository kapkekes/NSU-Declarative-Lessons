# Monad applications for trees

Package can be built using both **Stack** and **Cabal** on **Windows 11**.

Contains the following modules:
- `Data.Forest`, which describes basic structure of trees and provides some instances for them
- `Data.Forest.Simple`, which contains trees with values, uses the **Maybe** monad.
- `Data.Forest.WithID`, which contains trees with ID in nodes, uses the **Either**, **Writer** and **State** monads.
- `Data.Functor.Arithmetic`, which is just a bunch of shortcuts. (laziness, laziness...)

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