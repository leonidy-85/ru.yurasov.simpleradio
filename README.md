# Простое онлайн радио

Простое онлайн радио

The source code of the project is provided under
[the license](LICENSE.BSD-3-CLAUSE.md),
that allows it to be used in third-party applications.

## Project Structure

The project has a common structure
of an application based on C++ and QML for Aurora OS.

* **[ru.yurasov.SimpleRadio.pro](ru.yurasov.SimpleRadio.pro)** file
  describes the project structure for the qmake build system.
* **[icons](icons)** directory contains application icons for different screen resolutions.
* **[qml](qml)** directory contains the QML source code and the UI resources.
  * **[cover](qml/cover)** directory contains the application cover implementations.
  * **[icons](qml/icons)** directory contains the custom UI icons.
  * **[pages](qml/pages)** directory contains the application pages.
  * **[SimpleRadio.qml](qml/SimpleRadio.qml)** file
    provides the application window implementation.
* **[rpm](rpm)** directory contains the rpm-package build settings.
  **[ru.yurasov.SimpleRadio.spec](rpm/ru.yurasov.SimpleRadio.spec)** file is used by rpmbuild tool.
  It is generated from **[ru.yurasov.SimpleRadio.yaml](rpm/ru.yurasov.SimpleRadio.yaml)** file.
* **[src](src)** directory contains the C++ source code.
  * **[main.cpp](src/main.cpp)** file is the application entry point.
* **[translations](translations)** directory contains the UI translation files.
* **[ru.yurasov.SimpleRadio.desktop](ru.yurasov.SimpleRadio.desktop)** file
  defines the display and parameters for launching the application.
