﻿using System;
using System.Collections.Generic;

namespace Cardiology.Utils
{
    class JournalShuffleUtils
    {
        private static List<string> JOURNALS = new List<string>() { "Состояние пациента средней тяжести. В легких дыхание проводится во все отделы.  Хрипов нет.  ЧД 17 в мин. ЧСС 95в мин. АД  130/80 мм рт ст. Живот обычной формы; безболезненный",
            "Над легкими аускультативно: дыхание жесткое, ослабленное в нижних отделах. ЧД 17 в мин. Тоны сердца приглушены, ритмичные. ЧСС89  в мин. АД  120/80 мм рт ст. Живот обычной формы; безболезненный.",
            "Состояние средней тяжести. Над легкими аускультативно – хрипы не проводятся, патологических шумов нет.  ЧД 17 в мин. ЧСС98 в мин. АД  120/80 мм рт ст. Тоны сердца ритмичные, не выслушиваются.  Живот обычной формы; безболезненный.",
            "Состояние средней тяжести. Над легкими дыхание проводится во все отделы, несколько ослабленно в нижних отделах. ЧД 18 в мин. Тоны сердца приглушены, ритмичные. ЧСС 92 в мин. АД  120/80 мм рт ст.",
            "Состояние средней тяжести. ЧД 18 в мин. . ЧСС 92 в мин. АД  120/80 мм рт ст. В легких – дыхание физиологичное, проводится во все отделы. Тоны сердца ритмичные, патологических шумов не выслушивается. Живот обычной формы; безболезненный.Мочеиспускание – контролируется."};
        private static List<string> BAD_JOURNALS = new List<string>() {
            "Жалобы на дискомфорт в грудной клетке, чувство нехватки воздуха, беспокоит общая слабость. Объективно: Над легкими аускультативно: дыхание жесткое, ослабленное в нижних отделах. ЧД 18 в мин. Тоны сердца приглушены ритмичные. ЧСС 84 в мин. PS 84 в мин. АД 125/80 мм рт. ст. Живот обычной формы, безболезненный. По монитору - синусовый ритм. Назначено: нитроглицерин 2.0 мл/ч в/в",
            "Жалобы на чувство нехватки воздуха, беспокоит общая слабость, дискомфорт в грудной клетке. Объективно: Над легкими аускультативно: дыхание жесткое, ослабленное в нижних отделах. ЧД 18 в мин. Тоны сердца приглушены ритмичные. ЧСС 84 в мин. PS 84 в мин. АД 125/80 мм рт. ст. Живот обычной формы, безболезненный. По монитору - синусовый ритм. Назначено: нитроглицерин 2.0 мл/ч в/в"
        };
        internal static string shuffleJournalText()
        {
            Random rndm = new Random();
            return JOURNALS[rndm.Next(JOURNALS.Count - 1)];
        }
        internal static string shuffleBadJournalText()
        {
            Random rndm = new Random();
            return BAD_JOURNALS[rndm.Next(BAD_JOURNALS.Count - 1)];
        }

        internal static int shuffleNextIndex(int max)
        {
            Random rndm = new Random();
            return rndm.Next(max);
        }

        internal static int shuffleNextValue(int minValue, int maxValue)
        {
            Random rndm = new Random();
            return rndm.Next(minValue, maxValue);
        }

    }
}