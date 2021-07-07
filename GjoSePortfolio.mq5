/*

   EA GjoSePortfolio.mq5
   Copyright 2021, Gregory Jo
   https://www.gjo-se.com

   Version History
   ===============

   3.0 Initial version

   ===============

*/

//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include "Basics\\Includes.mqh"

//+------------------------------------------------------------------+
//| Headers                                                          |
//+------------------------------------------------------------------+
#property copyright   "2021, GjoSe"
#property link        "http://www.gjo-se.com"
#property description "GjoSe Portfolio"
#define   VERSION "3.0"
#property version VERSION
#property strict

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
   
   initializeStrategy_892();
   initializeStrategy_980();

   return(INIT_SUCCEEDED);
}

void OnTick() {

   //Print("--------------------------OnTick----positionTickets---------------");
   //printArrayOneDimension(positionTickets, ArraySize(positionTickets));

   bool tradeable = true;

   if(Bars(Symbol(), PERIOD_CURRENT) < REQUIRED_BARS) {
      // Fehler werfen (Alert)
      tradeable = false;
      return;
   }

   if(InpTradeOnNewBar == true && NewBar() == false) {
      tradeable = false;
   }

   if(NewBar() == true) {
      Bar.Update(Symbol(), PERIOD_CURRENT);
   }

   if(tradeable == true) {

      handleStrategy_892();
      handleStrategy_980();

   }

}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
   Comment("");
   Print(__FUNCTION__, " UninitializeReason() = ", getUninitReasonText(UninitializeReason()));
}
//+------------------------------------------------------------------+
