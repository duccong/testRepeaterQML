#include "mediatilemodel.h"

MediaTileModel::MediaTileModel(QObject *_parent) : QObject(_parent)
{
    m_mediaInfo = new MediaInfoBaseModel();
}

MediaTileModel::~MediaTileModel()
{
    delete m_mediaInfo;
    m_mediaInfo = NULL;
}

MediaInfoBaseModel *MediaTileModel::mediaInfo()
{
    if (m_mediaInfo == nullptr) {
        return new MediaInfoBaseModel();
    }
    return m_mediaInfo;
}

bool test = true;
void MediaTileModel::onMainClicked(QVariant var1, QVariant var2)
{
    Q_UNUSED(var2)

}

void MediaTileModel::setMediaInfo(MediaInfoBaseModel *value)
{
    m_mediaInfo = value;
    emit mediaInfoChanged();
}
