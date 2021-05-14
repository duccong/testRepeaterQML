#include "mediatilecontroller.h"

MediaTileController::MediaTileController(QObject *parent)
    : QObject(parent)
{
    m_tileModel = new MediaTileModel();
}

MediaTileController::~MediaTileController()
{
    if (m_tileModel != nullptr) {
        delete m_tileModel;
        m_tileModel = nullptr;
    }
}

MediaTileController *MediaTileController::getInstance()
{
    static MediaTileController* m_instance = nullptr;
    if (m_instance == nullptr) {
        m_instance = new MediaTileController();
    }
    return m_instance;
}

MediaTileModel *MediaTileController::getModel()
{
    return m_tileModel;
}

int a = 0;
void MediaTileController::onMainClicked(QVariant var1, QVariant var2)
{
    qDebug("MediaTileController::onMainClicked");
    a++;
    if (var1.toInt() == 1) {
        qDebug("MediaTileController::setMediaInfo");
        m_tileModel->setMediaInfo(interface<MediaInfoBaseModel>());
    } else {
        interface<MediaInfoBaseModel>()->setTileName(QString::number(a));
    }
}

