#ifndef ANIMALMODEL_H
#define ANIMALMODEL_H
#include <QAbstractListModel>
#include <QDebug>
#include <QRandomGenerator>
#include <QDateTime>

class Animal{
public:
    Animal(const QString &type, const QString &size);

    QString type() const;
    QString size() const;

private:
    QString m_type;
    QString m_size;
};

class AnimalModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum AnimalRoles {
        TypeRole = Qt::UserRole + 1,
        SizeRole
    };

    AnimalModel(QObject *parent = 0);
    void addAnimal(const Animal &animal);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    int getRand(int min, int max);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Animal> m_animals;

//signals:
public slots:
    void onMainClicked(QVariant var1, QVariant var2);

};

#endif // ANIMALMODEL_H
