# FruitsDiet-master

Headler.h надо будет скорее всего путь прописать новый

Все в первом уровне я над ним эксперементирую (DetailViewController) Swa.plist словарь, Будет не понятно пиши в скайп я как увижу так сразу отвечу. 
Как перейдеш на ячейку там есть ввод текста и кнопка микрофона(нужно с текстом разобратся ) 

Введеш на первом уровне к первой картинке Ant учитывая регистр. Вот тут и надо после правильного ответа чтоб в словаре поменялось значение correctText из False на True с записью на swa.plist

Все что не обходимо на начальном Этапе )) Буду примного Благодарен если поможеш разобратся (Сильно не злись занимаюсь всем этим почти 1 месяц в этом деле Новичок(User))!
Хорошо вписал я:
            let path = NSBundle.mainBundle().pathForResource("Swa", ofType: "plist")
            let resultDictionary = NSMutableArray(contentsOfFile: path!)
            resultDictionary!.setObject(NSNumber(bool: true), atIndexedSubscript: "correctText")
            resultDictionary!.writeToFile(path!, atomically: true)
            
          atIndexedSubscript: ????? что имеет ввиду под аргументом имени?
