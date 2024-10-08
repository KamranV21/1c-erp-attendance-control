# Контроль рабочего времени сотрудников

Расширение для контроля заполнения рабочего времени сотрудников организации.

## Принцип работы

В 1С из внешней системы загружаются данные прихода и ухода сотрудников, на основании чего вычситывается время их присутствия на рабочем месте. Далее при заполнении табеля часы явки перезаполняется данными фактического присутствия сотрудников, но без учета сверхурочных (их учет ведется отдельно). При этом считается, что каждое отклонение рабочего времени сотрудника от его нормы должно быть обосновано и зафиксировано в системе. Т.е. если сотрудник по какой-либо причине отработал меньше суточной нормы, то неотработанные часы необходимо обосновать - ввести документ, регистрирующий причину отсутствия сотрудника. Это может быть отпуск, больничный, отгул и т.д. В рамках месяца устанавливается лимит допустимых часов отсутствия сотрудников без указания их обоснований, а также высчитывается статус заполнения рабочего времени по сотруднику:

- Зеленый: у сотрудника за весь период нет необоснованных отсутствий
- Желтый: у сотрудника есть необоснованные отсутствия за период, но их общее число не превышает установленный лимит
- Красный: общее число необоснованных отсутствий сотрудника за период превышает установленный лимит

В случае наличия в табеле сотрудников с красным статусом, документ не проводится, а пользователю выдается соответствующее сообщение об ошибке заполнения.

## Документация

Документация доступна по ссылке:
[Документация](https://kamranv21.github.io/1c-erp-attendance-control/#/)
