# HW_5_OTUS_2023

Реализовать для приложения https://ru.wikipedia.org/wiki/Суффиксный_массив
1 Внутри приложения поле ввода для текста
2 Показывать в приложении(пункт 3.1) статистику совпадения суффиксов более 3х символов, например:
"
бра – 2
кад.– 3
"
Перед показом View разложить все полученные слова в тексте на SuffixSequence
1 Как показано в уроке создать SuffixIterator
2 Обернуть в SuffixSequence каждое слово из полученное из шаринга
В этом View:
1 Отображать Segmented Control(Picker в SwiftUI) переключения между
1.1 листом всех суффиксов, повторяющиеся помечать кол-вом, остортировать по алфавиту, сделать переключение сортировки ASC/DESC
1.2 топом 10 самых популярных 3х буквенных суффиксов, отсортированных по кол-ву нахождений
*4. Добавить поиск на лист 2.1.1
4.1 Искать по совпадением используя debounce в 500мс из Combine
