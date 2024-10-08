﻿
#Область ПрограммныйИнтерфейс

// Процедура формирования движений по регистру "Посещаемость сотрудников".
//
// Параметры:
//  ДополнительныеСвойства - Структура - Структура дополнительных свойств для проведения.
//  Движения - Структура - Структура наборов движений документа.
//  Отказ - Булево - Признак отказа от проведения документа.
//
Процедура ОтразитьПосещаемостьСотрудников(ДополнительныеСвойства, Движения, Отказ) Экспорт

	ТаблицаПосещаемостьСотрудников = ДополнительныеСвойства.ТаблицыДляДвижений.ТаблицаКРВС_ПосещаемостьСотрудников;

	Если Отказ Или ТаблицаПосещаемостьСотрудников.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;

	ДвиженияПосещаемостьСотрудников = Движения.КРВС_ПосещаемостьСотрудников;
	ДвиженияПосещаемостьСотрудников.Записывать = Истина;
	ДвиженияПосещаемостьСотрудников.Загрузить(ТаблицаПосещаемостьСотрудников);

КонецПроцедуры  

// Процедура формирования движений по регистру "Освобождения от контроля рабочего времени".
//
// Параметры:
//  ДополнительныеСвойства - Структура - Структура дополнительных свойств для проведения.
//  Движения - Структура - Структура наборов движений документа.
//  Отказ - Булево - Признак отказа от проведения документа.
//
Процедура ОтразитьОсвобожденияОтКонтроляРабочегоВремени(ДополнительныеСвойства, Движения, Отказ) Экспорт

	ТаблицаОсвобожденияОтКонтроляРабочегоВремени = ДополнительныеСвойства.ТаблицыДляДвижений.ТаблицаКРВС_ОсвобожденияОтКонтроляРабочегоВремени;

	Если Отказ Или ТаблицаОсвобожденияОтКонтроляРабочегоВремени.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;

	ДвиженияОсвобожденияОтКонтроляРабочегоВремени = Движения.КРВС_ОсвобожденияОтКонтроляРабочегоВремени;
	ДвиженияОсвобожденияОтКонтроляРабочегоВремени.Записывать = Истина;
	ДвиженияОсвобожденияОтКонтроляРабочегоВремени.Загрузить(ТаблицаОсвобожденияОтКонтроляРабочегоВремени);

КонецПроцедуры  

// Процедура формирования движений по регистру "Время прихода-ухода сотрудников".
//
// Параметры:
//  ДополнительныеСвойства - Структура - Структура дополнительных свойств для проведения.
//  Движения - Структура - Структура наборов движений документа.
//  Отказ - Булево - Признак отказа от проведения документа.
//
Процедура ОтразитьВремяПриходаУходаСотрудников(ДополнительныеСвойства, Движения, Отказ) Экспорт

	ТаблицаВремяПриходаУходаСотрудников = ДополнительныеСвойства.ТаблицыДляДвижений.ТаблицаКРВС_ВремяПриходаУходаСотрудников;

	Если Отказ Или ТаблицаВремяПриходаУходаСотрудников.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;

	ДвиженияТаблицаВремяПриходаУходаСотрудников = Движения.КРВС_ВремяПриходаУходаСотрудников;
	ДвиженияТаблицаВремяПриходаУходаСотрудников.Записывать = Истина;
	ДвиженияТаблицаВремяПриходаУходаСотрудников.Загрузить(ТаблицаВремяПриходаУходаСотрудников);

КонецПроцедуры  

// Возвращает данные посещаемости сотрудников за период.
//
// Параметры: 
//  Организация - СправочникСсылка.Организации - Организация к отбору. 
//  Сотрудники - Массив Из СправочникСсылка.Сотрудники - Сотрудники к отбору. 
//  ДатаНачала - Дата - Дата начала. 
//  ДатаОкончания - Дата - Дата окончания. 
// 
// Возвращаемое значение:
//  РезультатЗапроса - результат запроса по данным посещаемости за период. 
//
Функция ДанныеПосещаемостиЗаПериод(Организация, Сотрудники, ДатаНачала, ДатаОкончания) Экспорт

	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	Посещаемость.Сотрудник КАК Сотрудник,
	                      |	Посещаемость.ПериодРегистрации КАК ПериодРегистрации,
	                      |	Посещаемость.Дата КАК Дата,
	                      |	ВЫБОР
	                      |		КОГДА ПараметрыКонтроляРабочегоВремени.ВариантОкругления = ЗНАЧЕНИЕ(Перечисление.КРВС_ВариантыОкругленияЧасовПосещения.ПоАрифметическимПравилам)
	                      |			ТОГДА ОКР(Посещаемость.ЧасыОборот, ПараметрыКонтроляРабочегоВремени.ТочностьЧасовПосещения)
	                      |		КОГДА ПараметрыКонтроляРабочегоВремени.ВариантОкругления = ЗНАЧЕНИЕ(Перечисление.КРВС_ВариантыОкругленияЧасовПосещения.ВПользуСотрудника)
	                      |			ТОГДА ОКР(Посещаемость.ЧасыОборот + 5 / (10 * (ПараметрыКонтроляРабочегоВремени.ТочностьЧасовПосещения + 1)), ПараметрыКонтроляРабочегоВремени.ТочностьЧасовПосещения)
	                      |		КОГДА ПараметрыКонтроляРабочегоВремени.ВариантОкругления = ЗНАЧЕНИЕ(Перечисление.КРВС_ВариантыОкругленияЧасовПосещения.ВПользуПредприятия)
	                      |			ТОГДА ОКР(Посещаемость.ЧасыОборот - 5 / (10 * (ПараметрыКонтроляРабочегоВремени.ТочностьЧасовПосещения + 1)), ПараметрыКонтроляРабочегоВремени.ТочностьЧасовПосещения)
	                      |	КОНЕЦ КАК Часы,
	                      |	НЕ ОсвобожденияОтКонтроля.Сотрудник ЕСТЬ NULL КАК ОсвобожденОтКонтроля
	                      |ИЗ
	                      |	РегистрНакопления.КРВС_ПосещаемостьСотрудников.Обороты(
	                      |			,
	                      |			,
	                      |			,
	                      |			Сотрудник В (&Сотрудники)
	                      |				И (Дата МЕЖДУ &ДатаНачала И &ДатаОкончания)) КАК Посещаемость
	                      |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.КРВС_ПараметрыКонтроляРабочегоВремениСотрудников.СрезПоследних(&ДатаНачала, Организация = &Организация) КАК ПараметрыКонтроляРабочегоВремени
	                      |		ПО (ИСТИНА)
	                      |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КРВС_ОсвобожденияОтКонтроляРабочегоВремени.СрезПоследних(
	                      |				,
	                      |				Сотрудник В (&Сотрудники)
	                      |					И Организация = &Организация) КАК ОсвобожденияОтКонтроля
	                      |		ПО Посещаемость.Сотрудник = ОсвобожденияОтКонтроля.Сотрудник
	                      |			И (Посещаемость.Дата МЕЖДУ ОсвобожденияОтКонтроля.ДатаНачала И ОсвобожденияОтКонтроля.ДатаОкончания)");
	Запрос.УстановитьПараметр("Сотрудники", Сотрудники);   
	Запрос.УстановитьПараметр("ДатаНачала", ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания", ДатаОкончания);   
	Запрос.УстановитьПараметр("Организация", Организация);

	Возврат Запрос.Выполнить();

КонецФункции

// Заполняет в табеле табличную часть контроля посещаемости нормативными часами.
//
// Параметры:
//  ДокументТабеля - ДокументОбъект.ТабельУчетаРабочегоВремени - Табель учета рабочего времени.   
//  Сотрудники - Массив Из СправочникСсылка.Сотрудники - сотрудники к отбору. 
//
Процедура ЗаполнитьТаблицуКонтроляПосещаемостиНормативнымиЧасами(ДокументТабеля, Сотрудники) Экспорт
	
	ДокументТабеля.КРВС_КонтрольПосещаемости.Очистить();
	
	МенеджерВременныхТаблиц = ВТНормаВремениСотрудниковЗаПериод(Сотрудники, ДокументТабеля.ДатаНачалаПериода, ДокументТабеля.ДатаОкончанияПериода);	
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	ВТНормаВремени.Сотрудник КАК Сотрудник,
	                      |	ДЕНЬ(ВТНормаВремени.Дата) КАК НомерДня,
	                      |	СУММА(ВТНормаВремени.ЧасыНорма) КАК НормаЧасов,
	                      |	СУММА(0) КАК ОбоснованныеЧасы,
	                      |	СУММА(0) КАК НеобоснованныеЧасы
	                      |ИЗ
	                      |	ВТНормаВремени КАК ВТНормаВремени
	                      |
	                      |СГРУППИРОВАТЬ ПО
	                      |	ВТНормаВремени.Сотрудник,
	                      |	ДЕНЬ(ВТНормаВремени.Дата)");      
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл 
		СтрокаТаблицыКонтроля = ДокументТабеля.КРВС_КонтрольПосещаемости.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаТаблицыКонтроля, Выборка);	
	КонецЦикла;
	
КонецПроцедуры

// Возвращает допустимые часы отсутствий без обоснований.
//
// Параметры:
//  Организация - СправочникСсылка.Организации - Организация. 
//  НачалоПериода - Дата - Начало периода. 
//  КонецПериода - Дата - Конец периода. 
//
// Возвращаемое значение:
//  Число - допустимые часы отсутствий без обоснований. 
//
Функция ДопустимыеЧасыОтсутствийБезОбоснований(Организация, НачалоПериода, КонецПериода) Экспорт

	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	ПараметрыКонтроляРабочегоВремени.ДопустимыеЧасыБезОбоснований * (1 + РАЗНОСТЬДАТ(&НачалоПериода, &КонецПериода, ДЕНЬ)) / ДЕНЬ(КОНЕЦПЕРИОДА(&КонецПериода, МЕСЯЦ)) КАК ДопустимыеЧасыБезОбоснований
	                      |ИЗ
	                      |	РегистрСведений.КРВС_ПараметрыКонтроляРабочегоВремениСотрудников.СрезПоследних(&НачалоПериода, Организация = &Организация) КАК ПараметрыКонтроляРабочегоВремени");	
  	Запрос.УстановитьПараметр("Организация", Организация);
  	Запрос.УстановитьПараметр("НачалоПериода", НачалоПериода);
  	Запрос.УстановитьПараметр("КонецПериода", КонецПериода);

	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда 
		Возврат Выборка.ДопустимыеЧасыБезОбоснований;
	КонецЕсли;                                       
	
	Возврат 0;

КонецФункции 

// Возвращает менеджер с временной таблицей нормативных данных рабочего времени сотрудников за период.
//
// Параметры:
//  Сотрудники - Массив Из СправочникСсылка.Сотрудники - Сотрудники. 
//  ДатаНачала - Дата - Дата начала. 
//  ДатаОкончания - Дата - Дата окончания. 
// 
// Возвращаемое значение:
//  МенеджерВременныхТаблиц - Менеджер временных таблиц. 
//
Функция ВТНормаВремениСотрудниковЗаПериод(Сотрудники, ДатаНачала, ДатаОкончания) Экспорт

	ПараметрыПолученияДанных = УчетРабочегоВремениРасширенный.ПараметрыПолученияДанныхУчетаВремени();
	ПараметрыПолученияДанных.ДатаНачала = ДатаНачала;
	ПараметрыПолученияДанных.ДатаОкончания = ДатаОкончания;
	ПараметрыПолученияДанных.ПолучатьДанныеПлан = Истина;
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	Сотрудники.Ссылка КАК Сотрудник,
	|	НАЧАЛОПЕРИОДА(&ДатаНачала, МЕСЯЦ) КАК Месяц,
	|	&ДатаАктуальности КАК ДатаАктуальности,
	|	&ДатаНачала КАК ДатаНачала,
	|	&ДатаОкончания КАК ДатаОкончания
	|ПОМЕСТИТЬ ВТСотрудники
	|ИЗ
	|	Справочник.Сотрудники КАК Сотрудники
	|ГДЕ
	|	Сотрудники.Ссылка В(&Сотрудники)");
    
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Сотрудники", Сотрудники);
	Запрос.УстановитьПараметр("ДатаНачала", ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания", ДатаОкончания);
	Запрос.УстановитьПараметр("ДатаАктуальности", ТекущаяДатаСеанса());
	Запрос.Выполнить();
	
	УчетРабочегоВремениРасширенный.СоздатьВТДанныеУчетаРабочегоВремениСотрудников(МенеджерВременныхТаблиц, Истина, ПараметрыПолученияДанных);
			
	Возврат МенеджерВременныхТаблиц;
	
КонецФункции

#КонецОбласти
