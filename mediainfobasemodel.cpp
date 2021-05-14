#include "mediainfobasemodel.h"

MediaInfoBaseModel::MediaInfoBaseModel(QObject *_parent, QString title) : QObject(_parent),m_tileName(title)
{

}

MediaInfoBaseModel::~MediaInfoBaseModel()
{
    qDebug("~MediaInfoBaseModel()");
}

QString MediaInfoBaseModel::tileName()
{
    return m_tileName;
}

void MediaInfoBaseModel::setTileName(QString value)
{
    if (m_tileName != value) {
        m_tileName = value;
        emit tileNameChanged();
    }
}
