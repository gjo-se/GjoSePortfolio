//+------------------------------------------------------------------+
//|                                                  OpenSellActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void openBuyOrderAction(int pStrategyIndex, int pStopLossPoints, int pTakeProfitPoints) {

   double volume  = getTradeSize(InpUseMoneyManagement, InpLotsPerEquity, InpFixedVolume);

   double stopLoss = BuyStopLoss(Symbol(), pStopLossPoints, Bid());
   if(stopLoss > 0) AdjustAboveStopLevel(Symbol(), stopLoss);

   double takeProfit = BuyTakeProfit(Symbol(), pTakeProfitPoints, Bid());
   if(takeProfit > 0) AdjustBelowStopLevel(Symbol(), takeProfit);
   
   string comment = InpComment + " " + IntegerToString(getMagicNumber(pStrategyIndex));

   Trade.MagicNumber(getMagicNumber(pStrategyIndex));
   Trade.FillType(getOrderFillingType());
   Trade.Buy(Symbol(), volume, stopLoss, takeProfit, comment);

   cleanPositionTicketsArrayAction();

}
//+------------------------------------------------------------------+

void openSellOrderAction(int pStrategyIndex, int pStopLossPoints, int pTakeProfitPoints) {

   double volume  = getTradeSize(InpUseMoneyManagement, InpLotsPerEquity, InpFixedVolume);

   double stopLoss = SellStopLoss(Symbol(), pStopLossPoints, Ask());
   if(stopLoss > 0) AdjustBelowStopLevel(Symbol(), stopLoss);

   double takeProfit = SellTakeProfit(Symbol(), pTakeProfitPoints, Ask());
   if(takeProfit > 0) AdjustAboveStopLevel(Symbol(), takeProfit);
   
   string comment = InpComment + " " + IntegerToString(getMagicNumber(pStrategyIndex));

   Trade.MagicNumber(getMagicNumber(pStrategyIndex));
   Trade.FillType(getOrderFillingType());
   Trade.Sell(Symbol(), volume, stopLoss, takeProfit, comment);

   cleanPositionTicketsArrayAction();

}
//+------------------------------------------------------------------+
bool getOpenPositionsFilter(int pStrategyIndex) {

   bool filter = false;
   long positionTicket = 0;

   int positionTicketsId = 0;
   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];
      if(PositionMagicNumber(positionTicket) == getMagicNumber(pStrategyIndex)) filter = true;
   }

   return (filter);
}
//+------------------------------------------------------------------+
