#include "animalmodel.h"

Animal::Animal(const QString &type, const QString &size): m_type(type), m_size(size)
{

}

QString Animal::type() const
{
    return m_type;
}

QString Animal::size() const
{
    return m_size;
}

AnimalModel::AnimalModel(QObject *parent) : QAbstractListModel(parent)
{

}

void AnimalModel::addAnimal(const Animal &animal)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_animals << animal;
    endInsertRows();
}

int AnimalModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_animals.count();
}

QHash<int, QByteArray> AnimalModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TypeRole] = "type";
    roles[SizeRole] = "size";
    return roles;
}

void AnimalModel::onMainClicked(QVariant var1, QVariant var2)
{
    qDebug()<< "AnimalModel::onMainClicked";
//    beginMoveRows(QModelIndex(),0,0,QModelIndex(),rowCount());
//    m_animals.move(0,rowCount()-1);
    int from = getRand(0,rowCount()-1);
    if (from == rowCount() -1) {
        from--;
    }
    int to = getRand(from + 1,rowCount()-1);
//    from = 1;
//    to = 2;
    qDebug()<< "AnimalModel:: MoveRows from:"<< from <<"to:"<< to;

//    beginMoveRows(QModelIndex(), from, from,QModelIndex(), to);
    beginMoveRows(QModelIndex(), from, from,QModelIndex(), to > from ? to + 1 : to);
    qDebug()<< "AnimalModel:: Model move from:"<< from <<"to:"<< to;
    m_animals.move(from, to);
    endMoveRows();
}

QVariant AnimalModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_animals.count())
        return QVariant();

    const Animal &animal = m_animals[index.row()];
    if (role == TypeRole)
        return animal.type();
    else if (role == SizeRole)
        return animal.size();
    return QVariant();
}

int AnimalModel::getRand(int min, int max){
    unsigned int ms = static_cast<unsigned>(QDateTime::currentMSecsSinceEpoch());
    std::mt19937 gen(ms);
    std::uniform_int_distribution<> uid(min, max);
    return uid(gen);
}
