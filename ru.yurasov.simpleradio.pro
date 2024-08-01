TARGET = ru.yurasov.simpleradio

CONFIG += \
    auroraapp


PKGCONFIG += \

SOURCES += \
    src/main.cpp \

HEADERS += \

DISTFILES += \
    AUTHORS.md \
    LICENSE.BSD-3-CLAUSE.md \
    README.md \
    qml/pages/MainPage.qml \
    qml/pages/SettingPage.qml \
    qml/pages/AboutPage.qml \
    qml/pages/StantionPage.qml \
    qml/components/AppBarMenu.qml \
    qml/db.js \
    radio.desktop \
    radio.png \
    rock.png \
    play.png \
    rocklogo.png \
    rpm/ru.yurasov.simpleradio.spec \
    stop.png

AURORAAPP_ICONS = 86x86 108x108 128x128 172x172

CONFIG += auroraapp_i18n

TRANSLATIONS += \
    translations/ru.yurasov.simpleradio.ts \
    translations/ru.yurasov.simpleradio-ru.ts \
