//+------------------------------------------------------------------+
//|                                            CleanArraysAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void cleanPositionTicketsArrayAction() {
   initializeArray(positionTickets);
   Positions.GetTickets(0, positionTickets);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void cleanPositionTicketsArrayAction(long pBaseMagicNumber) {
   initializeArray(positionTickets);
   Positions.GetTickets(pBaseMagicNumber, positionTickets);
}
//+------------------------------------------------------------------+
