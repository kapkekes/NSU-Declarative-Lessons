# Text Processing and Regular Expressions

I'm sure this package can be built using [**Stack**](https://get.haskellstack.org/stable/windows-x86_64-installer.exe) on **Windows 11**.

Also, first four tasks work in the case of building via **Cabal** on **Windows 11**. (and installed `pcre-heavy`, of course)

## How to prepare environment to building:
1. Check if `stack` is avalible:
```
> stack
stack - The Haskell Tool Stack
```
2. Open MSYS2 shell:
```
stack exec mintty
```
3. In the opened shell, install `pcre` and `iconv` C libraries:
```
pacman -S mingw-w64-x86_64-pcre
pacman -S mingw-w64-x86_64-iconv
```
4. That's all!

## How to build and run:
1. Download and unpack one of release archives.
2. Open Command Prompt or Windows Terminal (via <kbd>Win</kbd> + <kbd>R</kbd>, write `wt`, <kbd>Enter</kbd>).
3. Go to unpacked archive (`cd` for Command Prompt, `Set-Location` for PowerShell).
4. Build package:
```
stack build
```
5. Run programs using following commands:
```
stack run Task-1
stack run Task-2
stack run Task-3
stack run Task-4
stack run Task-5
```
6. All results will be stored in `resources` folder of package. For testing, you can use `resources/lecture.html` file, which is bundled with package. **Notice**, that installed C libraries aren't a default part of Windows, that's why some of compiled exe-files coundn't be launched directly (at least now I do not know how to do it).
7. That's all!
