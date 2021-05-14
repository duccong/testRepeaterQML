#ifndef MEDIATILECONTROLLER_H
#define MEDIATILECONTROLLER_H
#include "mediatilemodel.h"
#include "QObject"
namespace MediaInfo {
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
/* ====== SOURCE ONLINE MEDIA =====*/
enum MediaProviderId
{
    DEEZER  = 0,
    TUNE_IN,
    SPOTIFY,
};
}
/* ====== SOURCE USB =====*/
/* ====== SOURCE BT =====*/

using namespace MediaInfo;
class MediaTileController : public QObject
{
    Q_OBJECT
public:
    explicit MediaTileController(QObject *parent = nullptr);
    virtual ~MediaTileController();
public:
    static MediaTileController *getInstance();
    MediaTileModel *getModel();

    template<class T> T* interface() {
        static T* iface = nullptr;
        if(!iface) {
            //iface = new T(instance()->baseListener());
            iface = new T();
            qDebug("interface provider is created : append : '%s' ", iface->metaObject()->className());
            //append(iface);
        }
        return iface;
    }

public slots:
    void onMainClicked(QVariant var1, QVariant var2);

private:
    MediaTileModel *m_tileModel;
    MediaSourceId   m_currentSourceId;
    MediaProviderId m_currentProviderId;
};

#endif // MEDIATILECONTROLLER_H
