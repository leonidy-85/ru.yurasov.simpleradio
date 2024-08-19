TARGET = ru.yurasov.simpleradio

CONFIG += auroraapp
CONFIG += auroraapp_i18n

PKGCONFIG += \

SOURCES += \
    src/main.cpp \

HEADERS += \

DISTFILES += \
    AUTHORS.md \
    README.md \
    qml/pages/ImportPage.qml \
    qml/pages/MainPage.qml \
    qml/pages/SettingPage.qml \
    qml/pages/AboutPage.qml \
    qml/pages/StantionPage.qml \
    qml/pages/DetailsPage.qml \
    qml/components/AppBarMenu.qml \
    qml/PopupDialog.qml \
    qml/db.js \
    radio.desktop \
    radio.png \
    rock.png \
    play.png \
    rocklogo.png \
    rpm/ru.yurasov.simpleradio.spec \
    stop.png

AURORAAPP_ICONS = 86x86 108x108 128x128 172x172

TRANSLATIONS +=   translations/ru.yurasov.simpleradio-ru.ts

VERSION = $$system( egrep "^Version:\|^Release:" rpm/ru.yurasov.simpleradio.spec |tr -d "[A-Z][a-z]: " | tr "\\\n" "-" | sed "s/\.$//g"| tr -d "[:space:]")

DEFINES += APP_VERSION=\\\"$$VERSION\\\"
DEFINES += BUILD_YEAR=$$system(date '+%Y')

include(src/FileIO/FileIO.pri)
