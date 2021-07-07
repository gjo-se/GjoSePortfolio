//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+

int   ind0handler_892;
int   ind1handler_892;
int   ind2handler_892;
int   posType_892 = OP_FLAT;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void initializeStrategy_892() {

   // ----- Directional Indicators -----
   int Ind0Param0 = 8; // Period
   // ----- Stochastic -----
   int Ind1Param0 = 3; // %K Period
   int Ind1Param1 = 6; // %D Period
   int Ind1Param2 = 29; // Slowing
   int Ind1Param3 = 20; // Level
   // ----- Envelopes -----
   int Ind2Param0 = 34; // Period
   double Ind2Param1 = 0.88; // Deviation %

   ind0handler_892 = iADX(NULL, 0, Ind0Param0);
   ind1handler_892 = iStochastic(NULL, 0, Ind1Param0, Ind1Param1, Ind1Param2, MODE_SMA, 0);
   ind2handler_892 = iEnvelopes(NULL, 0, Ind2Param0, 0, MODE_SMA, PRICE_CLOSE, Ind2Param1);

}

void handleStrategy_892() {

   int   strategyIndex     = 892;
   int   stopLossPoints    = 0;
   int   takeProfitPoints  = 230;

   manageOpen_892(strategyIndex, stopLossPoints, takeProfitPoints);
   manageClose_892(strategyIndex);

}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void manageOpen_892(int pStrategyIndex, int pStopLossPoints, int pTakeProfitPoints) {

   double ind0buffer0[];
   CopyBuffer(ind0handler_892, 1, 1, 3, ind0buffer0);
   double ind0buffer1[];
   CopyBuffer(ind0handler_892, 2, 1, 3, ind0buffer1);

   double ind0val1 = ind0buffer0[2] - ind0buffer1[2];
   double ind0val2 = ind0buffer0[1] - ind0buffer1[1];
   bool ind0long  = ind0val1 < 0 - sigma && ind0val2 > 0 + sigma;
   bool ind0short = ind0val1 > 0 + sigma && ind0val2 < 0 - sigma;

   double ind1buffer[];
   CopyBuffer(ind1handler_892, MAIN_LINE, 1, 3, ind1buffer);
   double ind1val1 = ind1buffer[2];
   double ind1val2 = ind1buffer[1];
   bool ind1long  = ind1val1 < ind1val2 - sigma;
   bool ind1short = ind1val1 > ind1val2 + sigma;

   const bool canOpenLong  = ind0long && ind1long;
   const bool canOpenShort = ind0short && ind1short;

   if(canOpenLong && canOpenShort) return;

   if(canOpenLong && getOpenPositionsFilter(pStrategyIndex) == false) {
      openBuyOrderAction(pStrategyIndex, pStopLossPoints, pTakeProfitPoints);
      posType_892 = OP_BUY;
   } else if(canOpenShort && getOpenPositionsFilter(pStrategyIndex) == false) {
      openSellOrderAction(pStrategyIndex, pStopLossPoints, pTakeProfitPoints);
      posType_892 = OP_SELL;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void manageClose_892(int pStrategyIndex) {
   
   double ind2buffer0[];
   CopyBuffer(ind2handler_892, 0, 1, 2, ind2buffer0);
   double ind2buffer1[];
   CopyBuffer(ind2handler_892, 1, 1, 2, ind2buffer1);
   double ind2upBand1 = ind2buffer0[1];
   double ind2dnBand1 = ind2buffer1[1];
   double ind2upBand2 = ind2buffer0[0];
   double ind2dnBand2 = ind2buffer1[0];
   bool ind2long  = Open(0) > ind2dnBand1 + sigma && Open(1) < ind2dnBand2 - sigma;
   bool ind2short = Open(0) < ind2upBand1 - sigma && Open(1) > ind2upBand2 + sigma;

   if(posType_892 == OP_BUY && ind2long) {
      closeOrderAction(pStrategyIndex);
   } else if(posType_892 == OP_SELL && ind2short) {
      closeOrderAction(pStrategyIndex);
   }
   
}
//+------------------------------------------------------------------+
