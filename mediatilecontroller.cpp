#include "mediatilecontroller.h"

MediaTileController::MediaTileController(QObject *parent)
    : QObject(parent)
{
    m_model = new MediaTileModel();
}

MediaTileController::~MediaTileController()
{
    delete m_model;
    m_model = nullptr;
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
    return m_model;
}

void MediaTileController::setTitleName(QString strSourceId, QString strProviderId, QString _title)
{
    MediaSourceId _sourceId = mediaSourceIdMap[strSourceId];
    MediaProviderId _providerId = mediaProviderIdMap[strProviderId];
    if (_sourceId != ONLINE_MEDIA && _sourceId != m_currentSourceId) {
        // current source is not online media
        return;
    } else if (_sourceId == ONLINE_MEDIA && _providerId != m_currentProviderId) {
        // strProviderId is not current provider
        return;
    }
    switch (_sourceId) {
    case ONLINE_MEDIA:
    {
        switch (_providerId) {
        case TUNE_IN:
        {
        }
            break;
        case DEEZER:
        {
        }
            break;
        default:
            break;
        }
    }
        break;
    case USB:

        break;
    default:
        break;
    }
}

