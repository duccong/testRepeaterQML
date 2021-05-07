#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "animalmodel.h"
#include <QQmlContext>
#include <QObject>
#include <mediatilemodel.h>
#include <mediatilecontroller.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    AnimalModel* animalModel = new AnimalModel();
    animalModel->addAnimal(Animal("1. Wolf", "Medium"));
    animalModel->addAnimal(Animal("2. Polar bear", "Large"));
    animalModel->addAnimal(Animal("3. Quoll", "Small"));

    animalModel->addAnimal(Animal("4. Wolf -2", "Medium"));
    animalModel->addAnimal(Animal("5. Polar -2", "Large"));
    animalModel->addAnimal(Animal("6. Quoll -2", "Small"));

    animalModel->addAnimal(Animal("7. Wolf -3", "Medium"));
    animalModel->addAnimal(Animal("8. Polar -3", "Large"));
    animalModel->addAnimal(Animal("9. Quoll -3", "Small"));

    QQmlApplicationEngine engine;

    QQmlContext* m_content = engine.rootContext();
    m_content->setContextProperty("animalModel", animalModel);

    MediaTileController* mediaTileController = MediaTileController::getInstance();
    m_content->setContextProperty("mediaTileController", mediaTileController);
    m_content->setContextProperty("mediaModel", mediaTileController->getModel());

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QObject* main_win = engine.rootObjects().first();
//    QObject::connect(main_win, SIGNAL(mainClicked(QVariant,QVariant)), animalModel, SLOT(onMainClicked(QVariant,QVariant)));
//    QObject::connect(main_win, SIGNAL(mainClicked(QVariant,QVariant)), mediaTileController->getModel(), SLOT(onMainClicked(QVariant,QVariant)));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
