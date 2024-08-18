#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QtQml>
#include <qqml.h>
#include <QtGui>
#include <QQuickView>
#include <auroraapp.h>

#include "fileio.h"

using namespace Aurora;


int main(int argc, char *argv[])
{

    QGuiApplication* app = Application::application(argc, argv);
    QLocale::setDefault(QLocale::c());
    qmlRegisterType<FileIO, 1>("ru.yurasov.wallet.FileIO", 1, 0, "FileIO");

    QQuickView* view = Application::createView();
    view->rootContext()->setContextProperty("version", APP_VERSION);
    view->rootContext()->setContextProperty("buildyear", BUILD_YEAR);
    view->setSource(Aurora::Application::pathTo("qml/simpleradio.qml"));
    view->show();

    return app->exec();
}
