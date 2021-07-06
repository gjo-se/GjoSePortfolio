//+------------------------------------------------------------------+
//|                                                  OpenSellActions.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

void openBuyOrderAction(int pStrategyIndex, int pStopLossPoints, int pTakeProfitPoints) {

   Trade.MagicNumber(getMagicNumber(pStrategyIndex));

   double volume  = getTradeSize(InpUseMoneyManagement, InpLotsPerEquity, InpFixedVolume);

   double stopLoss = BuyStopLoss(Symbol(), pStopLossPoints, Bid());
   if(stopLoss > 0) AdjustAboveStopLevel(Symbol(), stopLoss);

   double takeProfit = BuyTakeProfit(Symbol(), pTakeProfitPoints, Bid());
   if(takeProfit > 0) AdjustBelowStopLevel(Symbol(), takeProfit);
   
   string comment = InpComment + " " + IntegerToString(getMagicNumber(pStrategyIndex));

   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Buy(Symbol(), volume, stopLoss, takeProfit, comment);

   cleanPositionTicketsArrayAction(pStrategyIndex);

}
//+------------------------------------------------------------------+

void openSellOrderAction(int pStrategyIndex, int pStopLossPoints, int pTakeProfitPoints) {

   Trade.MagicNumber(getMagicNumber(pStrategyIndex));

   double volume  = getTradeSize(InpUseMoneyManagement, InpLotsPerEquity, InpFixedVolume);

   double stopLoss = SellStopLoss(Symbol(), pStopLossPoints, Ask());
   if(stopLoss > 0) AdjustBelowStopLevel(Symbol(), stopLoss);

   double takeProfit = SellTakeProfit(Symbol(), pTakeProfitPoints, Ask());
   if(takeProfit > 0) AdjustAboveStopLevel(Symbol(), takeProfit);
   
   string comment = InpComment + " " + IntegerToString(getMagicNumber(pStrategyIndex));

   Trade.FillType(SYMBOL_FILLING_FOK);
   Trade.Sell(Symbol(), volume, stopLoss, takeProfit, comment);

   cleanPositionTicketsArrayAction(pStrategyIndex);

}
//+------------------------------------------------------------------+
bool getOpenPositionsFilter() {

   bool filter = false;
   long positionTicket = 0;

   int positionTicketsId = 0;
   for(positionTicketsId; positionTicketsId < ArraySize(positionTickets); positionTicketsId++) {
      positionTicket = positionTickets[positionTicketsId];
      if(PositionType(positionTicket) == ORDER_TYPE_BUY || PositionType(positionTicket) == ORDER_TYPE_SELL) filter = true;
   }

   return (filter);
}