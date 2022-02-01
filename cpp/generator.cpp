#include "generator.h"
#include <cstdlib>
#include <ctime>
#include <iostream>

using namespace std;

Generator::Generator(QObject *parent) : QObject(parent)
{
}

void Generator::buttonClicked(int n, bool a, bool b, bool c, bool d)
{
    string seed = "";

    if (a == true)
    {
        seed += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    }

    if (b == true)
    {
        seed += "abcdefghijklmnopqrstuvwxyz";
    }

    if (c == true)
    {
        seed += "0123456789";
    }

    if (d == true)
    {
        seed += "!@#$%^&*";
    }

    QString genPass = "";
    srand(time(0));

    if (seed == "")
    {
    }
    else
    {
        for (int i = 0; i < n; i++)
        {
            genPass += seed[rand() % seed.length()];
        }
    }

    emit generatedPassword(genPass);
}
