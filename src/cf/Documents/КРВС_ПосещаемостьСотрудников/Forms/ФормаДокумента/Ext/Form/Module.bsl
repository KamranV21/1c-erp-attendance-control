﻿		  
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		
	Если Параметры.Ключ.Пустая() Тогда
		ЗначенияДляЗаполнения = Новый Структура("Организация, Ответственный, МесяцРасчета", 
								"Объект.Организация", "Объект.Ответственный", "Объект.ПериодРегистрации");
		
		ЗарплатаКадры.ЗаполнитьПервоначальныеЗначенияВФорме(ЭтотОбъект, ЗначенияДляЗаполнения);
		
		ЗаполнитьДанныеФормыПоОрганизации();
	КонецЕсли;  
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект); 
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды	
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДате(ЭтотОбъект, "Объект.ПериодРегистрации", "МесяцРегистрацииСтрокой");
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКомандыКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиент");
		МодульПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти
		  
#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПериодРегистрацииНачалоВыбора(Элемент, ДанныеВыбора, ВыборДобавлением, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("ПериодРегистрацииНачалоВыбораЗавершение", ЭтотОбъект);
	ЗарплатаКадрыКлиент.ВводМесяцаНачалоВыбора(ЭтотОбъект, ЭтотОбъект, "Объект.ПериодРегистрации", "МесяцРегистрацииСтрокой", , Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура МесяцРегистрацииСтрокойПриИзменении(Элемент)
	
	ЗарплатаКадрыКлиент.ВводМесяцаПриИзменении(ЭтотОбъект, "Объект.ПериодРегистрации", "МесяцРегистрацииСтрокой", Модифицированность);
	
	ПериодРегистрацииПриИзменении();
	
КонецПроцедуры

&НаКлиенте
Процедура МесяцРегистрацииСтрокойРегулирование(Элемент, Направление, СтандартнаяОбработка)
	
	ЗарплатаКадрыКлиент.ВводМесяцаРегулирование(ЭтотОбъект, "Объект.ПериодРегистрации", "МесяцРегистрацииСтрокой", Направление, Модифицированность);
	
	ПериодРегистрацииПриИзменении();
	
КонецПроцедуры

&НаКлиенте
Процедура МесяцРегистрацииСтрокойАвтоПодбор(Элемент, Текст, ДанныеВыбора, Ожидание, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаАвтоПодборТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура МесяцРегистрацииСтрокойОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаОкончаниеВводаТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры 

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДанныеОВремени

 &НаКлиенте
Процедура ДанныеОВремениПриАктивизацииЯчейки(Элемент)
	
	ТекущиеДанные = Элементы.ДанныеОВремени.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;	
	КонецЕсли; 
	
	Если Элемент.ТекущийЭлемент = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДеньСтрокой = СтрЗаменить(Элемент.ТекущийЭлемент.Имя, "ДанныеОВремениЧасов", "");
	День = СтроковыеФункцииКлиентСервер.СтрокаВЧисло(ДеньСтрокой);
	
	Элементы.Посещаемость.ОтборСтрок = Новый ФиксированнаяСтруктура("Сотрудник, День", ТекущиеДанные.Сотрудник, День);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы 

&НаКлиенте
Асинх Процедура ЗаполнитьИзHikvision(Команда)
	
	Если Объект.ДанныеОВремени.Количество() > 0 Тогда   
		ТекстВопроса = НСтр("ru = 'Табличная часть будет очищена. Продолжить?'; en = 'The tabular part will be cleared. Continue?'; az = 'Cədvəl hissəsi təmizlənəcəkdir. Davam etmək?'");
		Ответ = Ждать ВопросАсинх(ТекстВопроса, РежимДиалогаВопрос.ДаНет); 
		Если Ответ = КодВозвратаДиалога.Нет Тогда       
			Возврат;
		КонецЕсли;  
	КонецЕсли;      
	
	ОчиститьТабличныеЧастиДокумента();
	
	ДлительнаяОперация = ЗагрузитьДанныеПосещаемостиИзHikvision();
	ИДЗадания = ДлительнаяОперация.ИдентификаторЗадания;
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ВыводитьПрогрессВыполнения = Ложь;
	ПараметрыОжидания.ВыводитьОкноОжидания = Истина;
	ПараметрыОжидания.ВыводитьСообщения = Истина;

	Оповещение = Новый ОписаниеОповещения("ПриЗавершенииЗагрузкиДанныхИзБазыHikvision", ЭтотОбъект);
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, Оповещение, ПараметрыОжидания);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

&НаСервере
Процедура ЗаполнитьДанныеФормыПоОрганизации()
	
	Если НЕ ЗначениеЗаполнено(Объект.Организация) Тогда
		Возврат;
	КонецЕсли;
	
	ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДате(ЭтотОбъект, "Объект.ПериодРегистрации", "МесяцРегистрацииСтрокой");
		
КонецПроцедуры

&НаКлиенте
Процедура ПериодРегистрацииНачалоВыбораЗавершение(ЗначениеВыбрано, ДополнительныеПараметры) Экспорт
	
	ПериодРегистрацииПриИзменении();
	
КонецПроцедуры

&НаКлиенте
Процедура ПериодРегистрацииПриИзменении()
	
	ОбнулитьЗначенияОтсутствующихДнейМесяца();   
	УстановитьВидимостьДнейМесяца();

КонецПроцедуры

&НаКлиенте
Процедура ОбнулитьЗначенияОтсутствующихДнейМесяца()
		
	КонецМесяца = КонецМесяца(Объект.ПериодРегистрации);
	КоличествоДнейВМесяце = День(КонецМесяца); 
	
	Отклонение = 1;
	ДеньОтсутствующийВМесяце = КоличествоДнейВМесяце + Отклонение;
	
	МаксимальноеКоличествоДнейВМесяце = 31;	
	
	Для День = ДеньОтсутствующийВМесяце По МаксимальноеКоличествоДнейВМесяце Цикл
		
		Для Каждого СтрокаДанныхВремени Из Объект.ДанныеОВремени Цикл
			СтрокаДанныхВремени["Часов" + День] = 0;
		КонецЦикла;
		
		СтруктураПоиска = Новый Структура("День", День);
		НайденныеСтроки = Объект.Посещаемость.НайтиСтроки(СтруктураПоиска);
		Для Счетчик = 0 По НайденныеСтроки.Количество() - 1 Цикл
			НайденнаяСтрока = НайденныеСтроки[Счетчик];
			НайденныеСтроки.Удалить(НайденнаяСтрока);
		КонецЦикла;
		
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура УстановитьВидимостьДнейМесяца()
	
	КонецМесяца = КонецМесяца(Объект.ПериодРегистрации);
	КоличествоДнейВМесяце = День(КонецМесяца);    
	ПервыйДеньМесяца = 1; 
	МаксимальноеКоличествоДнейВМесяце = 31;
	
	Для День = ПервыйДеньМесяца По МаксимальноеКоличествоДнейВМесяце Цикл
		Элементы["ДанныеОВремениЧасов" + День].Видимость = День <= КоличествоДнейВМесяце;	
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура ОчиститьТабличныеЧастиДокумента()
	
	Объект.ДанныеОВремени.Очистить();
	Объект.Посещаемость.Очистить();

КонецПроцедуры

&НаСервере
Функция ЗагрузитьДанныеПосещаемостиИзHikvision()
	
	ДатаНачала = НачалоМесяца(Объект.ПериодРегистрации); 
	ДатаОкончания = КонецМесяца(Объект.ПериодРегистрации);
	
	ПараметрыЗагрузки = Новый Структура;
	ПараметрыЗагрузки.Вставить("ДатаНачала", ДатаНачала);
	ПараметрыЗагрузки.Вставить("ДатаОкончания", ДатаОкончания);

	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияФункции(УникальныйИдентификатор);
	Возврат ДлительныеОперации.ВыполнитьФункцию(ПараметрыВыполнения, "КРВС_ОбменСHikvision.ДанныеПосещаемостиЗаПериод", ПараметрыЗагрузки);
		
КонецФункции

&НаКлиенте
Процедура ПриЗавершенииЗагрузкиДанныхИзБазыHikvision(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Результат.Статус = "Ошибка" Тогда
		ВызватьИсключение Результат.КраткоеПредставлениеОшибки;
	КонецЕсли;

	Для Каждого Сообщение Из Результат.Сообщения Цикл
		ОбщегоНазначенияКлиент.СообщитьПользователю(Сообщение.Текст, Сообщение.КлючДанных, Сообщение.Поле,
			Сообщение.ПутьКДанным);
	КонецЦикла;
	
	ПриЗавершенииЗагрузкиДанныхИзБазыHikvisionНаСервере(Результат);

КонецПроцедуры

&НаСервере
Процедура ПриЗавершенииЗагрузкиДанныхИзБазыHikvisionНаСервере(Результат)

	ДанныеПосещаемости = ПолучитьИзВременногоХранилища(Результат.АдресРезультата);
	УдалитьИзВременногоХранилища(Результат.АдресРезультата);
	
	ЗаполнитьТаблицуПосещаемостиПоДаннымИзHikvision(ДанныеПосещаемости);
	ЗаполнитьТаблицуДанныхОВремениПоДаннымПосещаемости();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуПосещаемостиПоДаннымИзHikvision(ДанныеПосещаемости)
		
	Для Каждого СтрокаТаблицыПосещаемости Из ДанныеПосещаемости Цикл
		НоваяСтрокаПосещаемости = Объект.Посещаемость.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрокаПосещаемости, СтрокаТаблицыПосещаемости);         
		НоваяСтрокаПосещаемости.День = День(НоваяСтрокаПосещаемости.Дата);
	КонецЦикла;

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуДанныхОВремениПоДаннымПосещаемости()

	ЗначениеОбъекта = РеквизитФормыВЗначение("Объект");
	ЗначениеОбъекта.ЗаполнитьТаблицуДанныхОВремениПоДаннымПосещаемости();
	ЗначениеВРеквизитФормы(ЗначениеОбъекта, "Объект");

КонецПроцедуры

#КонецОбласти
