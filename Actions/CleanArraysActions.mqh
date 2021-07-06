//+------------------------------------------------------------------+
//|                                            CleanArraysAction.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void cleanPositionTicketsArrayAction(int pStrategyIndex) {
   initializeArray(positionTickets, 100);
   Positions.GetTickets(InpBaseMagicNumber + pStrategyIndex, positionTickets);
}