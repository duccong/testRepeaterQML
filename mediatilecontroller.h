#ifndef MEDIATILECONTROLLER_H
#define MEDIATILECONTROLLER_H
#include "mediatilemodel.h"
#include "QObject"

class MediaTileController : public QObject
{
    Q_OBJECT
public:
    explicit MediaTileController(QObject *parent = nullptr);
    virtual ~MediaTileController();
public:
    static MediaTileController *getInstance();
    MediaTileModel *getModel();
    void setTitleName(QString strSourceId, QString strProviderId, QString _title);

private:
    MediaTileModel *m_model;
    MediaSourceId   m_currentSourceId;
    MediaProviderId m_currentProviderId;

    enum MediaSourceId
    {
        AM = 0,
        FM,
        DAB,
        SXM,
        CARPLAY,
        ANDROID_AUTO,
        USB,
        BT,
        ONLINE_MEDIA

    };

    QMap<QString, int> mediaSourceIdMap = {
        {"AM"           ,  AM           },
        {"FM"           ,  FM           },
        {"DAB"          ,  DAB          },
        {"SXM"          ,  SXM          },
        {"CARPLAY"      ,  CARPLAY      },
        {"ANDROID_AUTO" ,  ANDROID_AUTO },
        {"USB"          ,  USB          },
        {"BT"           ,  BT           },
        {"ONLINE_MEDIA" ,  ONLINE_MEDIA }
    };

    /* ====== SOURCE ONLINE MEDIA =====*/
    enum MediaProviderId
    {
        DEEZER  = 0,
        TUNE_IN,
        SPOTIFY,
    };

    QMap<QString, int> mediaProviderIdMap = {
        {"deezer" , DEEZER },
        {"tunein" , TUNE_IN},
        {"spotify", SPOTIFY}
    };
    /* ====== SOURCE USB =====*/
    /* ====== SOURCE BT =====*/

};

#endif // MEDIATILECONTROLLER_H
