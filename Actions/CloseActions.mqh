//+------------------------------------------------------------------+
//|                                                 CloseActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void closeOrderAction(int pStrategyIndex) {

   long positionTicket = 0;
   int positionProfitPoints = 0;

   for(int positionTicketIndex = 0; positionTicketIndex < ArraySize(positionTickets); positionTicketIndex++) {
      positionTicket = positionTickets[positionTicketIndex];
      string comment = IntegerToString(pStrategyIndex) + "_" + IntegerToString(positionTicket);
      
      if(PositionMagicNumber(positionTicket) == getMagicNumber(pStrategyIndex)) {
         Trade.Close(positionTicket, PositionVolume(positionTicket), comment);
      }
   }

   cleanPositionTicketsArrayAction(pStrategyIndex);

}
//+------------------------------------------------------------------+
