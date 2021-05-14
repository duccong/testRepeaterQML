#ifndef MEDIATILEMODEL_H
#define MEDIATILEMODEL_H
#include "QObject"
#include "QVariant"
#include "mediainfobasemodel.h"

class MediaTileModel : public QObject
{
    Q_OBJECT
    // Media info
    Q_PROPERTY(MediaInfoBaseModel* mediaInfo READ mediaInfo WRITE setMediaInfo NOTIFY mediaInfoChanged)

    // Media List

    // UpNext List...

private:
    MediaInfoBaseModel *m_mediaInfo;
public:
    explicit MediaTileModel(QObject *_parent = nullptr);
    virtual ~MediaTileModel();

public:
    MediaInfoBaseModel *mediaInfo();


public slots:
    void onMainClicked(QVariant var1, QVariant var2);
    void setMediaInfo(MediaInfoBaseModel *value);

signals:
      void mediaInfoChanged();
};

#endif // MEDIATILEMODEL_H
