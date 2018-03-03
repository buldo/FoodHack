using System;
using System.Collections.Generic;

namespace MyFood.Persistence
{
    internal static class Data
    {
        private static readonly Guid Demo1Id = Guid.Parse("9B1D56CF-17B1-4888-94E6-C4A6F3227CA1");

        public static IEnumerable<Recipe> GetAll()
        {
            return new List<Recipe>()
            {
                new Recipe
                {
                    Id = Guid.NewGuid(),
                    Title = "Омлет",
                    Description = "Количество существующих омлетов вряд ли можно сосчитать на пальцах даже обеих рук. Изобретательные хозяюшки то и дело не перестают проводить эксперименты и получать новые интересные сочетания. Так, сегодня предлагаем на замену традиционному омлету на молоке поставить не менее интересный вариант – наш омлет. На завтрак или обед/перекус – самое то!",
                    Complexity = "Легко",
                    Duration = "15 минут",
                    PreviewUrl = @"http://tvoirecepty.ru/files/imagecache/colorbox/recept/recept-omlet-na-kefire-shag_6.jpg",
                    Ingredients = new List<string>
                    {
                        "Яйцо куриное -  1 шт",
                        "Молоко - 2 ст.л.",
                        "Соль - щепотка",
                        "Лук зеленый - половина пучок",
                        "Сыр твердый - 20 г",
                        "Масло растительное - 0.5 столовой ложки"
                    },
                    Devices = new List<string>
                    {
                        "Нож",
                        "Терка",
                        "Сковородка",
                        "Венчик или вилка",
                        "Лопатка"
                    },
                    Steps = new List<Step>
                    {
                        new Step
                        {
                            Order = 1,
                            Description = "Взбейте яйца с солью и молоком",
                            PictureUrl = @"http://tvoirecepty.ru/files/imagecache/colorbox/recept/recept-omlet-na-kefire-shag_0.jpg",
                            TimeInSec = null,
                            VoiceDescription = "Взбейте яйца с солью и молоком",
                            Tips = new List<string>
                            {
                                "Здесь не понадобится много усилий, миксеров и прочей техники, работать нужно спокойно и размеренно"
                            }
                        },
                        new Step
                        {
                            Order = 2,
                            Description = "Через 10 минут проверь, загустел ли омлет",
                            PictureUrl = @"http://tvoirecepty.ru/files/imagecache/colorbox/recept/recept-omlet-na-kefire-shag_4.jpg",
                            TimeInSec = 600,
                            VoiceDescription = "Через 10 минут проверь, загустел ли омлет",
                            PushText = "Пора проверить, загустел ли омлет"
                        }
                    }
                }
            };
        }
    }
}