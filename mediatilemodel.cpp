#include "mediatilemodel.h"

MediaTileModel::MediaTileModel(QObject *_parent) : QObject(_parent)
{

}

QString MediaTileModel::tileName()
{
    return m_tileName;
}

bool test = true;
void MediaTileModel::onMainClicked(QVariant var1, QVariant var2)
{
    Q_UNUSED(var2)
    if (test) {
        setTileName(var1.toString());
    } else {
        setTileName("Media");
    }
    test = !test;

}

void MediaTileModel::setTileName(QString value)
{
    if (m_tileName != value) {
        m_tileName = value;
        emit tileNameChanged();
    }
}
