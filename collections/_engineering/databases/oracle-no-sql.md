---
layout: single
---

## Export import a table into json and vice versa
Export
get table -name member -file fulldata.member.json;

Import 
put table -name member -file fulldata.member.json;

Its important that the export is done on linux. Windows is not able to write a proper UTF8 file somehow...


# useful SQL commands

## change mode
```
mode json
```
``` mode line```

## =any
```
select * from instrument i where i.jsonContent.instrumentIDs.instrumentID =any 'testInstr';
```
## EXISTS
```
select customerId from edUserEntitlements ed where EXISTS ed.jsonContent.entitlements."175.000.200.001".permissibleEntities."26349";
```
## COUNT(*)
```
select count(*) from channels c where c.jsonContent.channelType=0;
```
## UPDATE
```
update contentdatalookup c put c.jsoncontent {'state': 'DUPLICATED'} where not exists c.jsoncontent.state" 
```
## DELETE
```
delete from contentDataLookup;
```