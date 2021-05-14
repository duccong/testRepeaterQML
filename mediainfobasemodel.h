#ifndef MEDIAINFOBASEMODEL_H
#define MEDIAINFOBASEMODEL_H

#include "QObject"
#include "QVariant"

class MediaInfoBaseModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString tileName READ tileName WRITE setTileName NOTIFY tileNameChanged)

private:
    QString  m_providerId          = "m_providerId";
    QString  m_provider            = "m_provider";
    QString  m_sourceId            = "m_sourceId";
    QString  m_source              = "m_source";
    QString  m_tileName            = "Media";
    QString  m_title               = "title";
    int      m_progressValue       = 50;
    QString  m_subTitle1           = "subTitle1";
    QString  m_subTitle2           = "subTitle2";
    QString  m_subTitle3           = "subTitle3";
    QString  m_specialText1        = "specialText1";
    QString  m_sourceButton1       = "1"; // Left buttton
    bool     m_isButton1Enable      = true;
    int      m_stateButton1         = 10;
    QString  m_sourceButton2       = "2"; // Center buttton
    bool     m_isButton2Enable      = true;
    int      m_stateButton2         = 20;  // [PLAY, PAUSE, MUTE, UN_MUTE,...]
    QString  m_sourceButton3       = "3";// Right buttton
    bool     m_isButton3Enable      = true;
    int      m_stateButton3         = 30;   // [FARVORITE, UPNEXT,...]
public:
    explicit MediaInfoBaseModel(QObject *_parent = nullptr, QString title = "Select Source");
    ~MediaInfoBaseModel();

public:
    QString tileName();

public slots:
    void setTileName(QString value);

signals:
      void tileNameChanged();
};

#endif // MEDIAINFOBASEMODEL_H
