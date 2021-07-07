//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+

int   posType_980 = OP_FLAT;

int ind0handler;
int ind1handler;
int ind2handler;
int ind21handler;
int ind3handler;
int ind4handler;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void initializeStrategy_980() {

   // ----- Envelopes -----
   int Ind0Param0 = 36; // Period
   double Ind0Param1 = 0.27; // Deviation %
   // ----- Average True Range -----
   int Ind1Param0 = 11; // Period
   double Ind1Param1 = 0.0100; // Level
   // ----- Moving Averages Crossover -----
   int Ind2Param0 = 6; // Fast MA period
   int Ind2Param1 = 26; // Slow MA period
   // ----- DeMarker -----
   int Ind3Param0 = 21; // Period
   double Ind3Param1 = 0.78; // Level
   // ----- Momentum -----
   int Ind4Param0 = 16; // Period
   double Ind4Param1 = 100.0000; // Level

   ind0handler = iEnvelopes(NULL, 0, Ind0Param0, 0, MODE_SMA, PRICE_CLOSE, Ind0Param1);
   ind1handler = iATR(NULL, 0, Ind1Param0);
   ind2handler = iMA(NULL, 0, Ind2Param0, 0, MODE_SMA, PRICE_CLOSE);
   ind21handler = iMA(NULL, 0, Ind2Param1, 0, MODE_SMA, PRICE_CLOSE);
   ind3handler = iDeMarker(NULL, 0, Ind3Param0);
   ind4handler = iMomentum(NULL, 0, Ind4Param0, PRICE_CLOSE);
}

void handleStrategy_980() {

   int   strategyIndex     = 980;
   int   stopLossPoints    = 0;
   int   takeProfitPoints  = 0;

   manageClose_980(strategyIndex);
   manageOpen_980(strategyIndex, stopLossPoints, takeProfitPoints);

}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void manageOpen_980(int pStrategyIndex, int pStopLossPoints, int pTakeProfitPoints) {

   double ind0buffer0[];
   CopyBuffer(ind0handler, 0, 1, 2, ind0buffer0);
   double ind0buffer1[];
   CopyBuffer(ind0handler, 1, 1, 2, ind0buffer1);
   double ind0upBand1 = ind0buffer0[1];
   double ind0dnBand1 = ind0buffer1[1];
   double ind0upBand2 = ind0buffer0[0];
   double ind0dnBand2 = ind0buffer1[0];
   bool ind0long  = Open(0) < ind0upBand1 - sigma && Open(1) > ind0upBand2 + sigma;
   bool ind0short = Open(0) > ind0dnBand1 + sigma && Open(1) < ind0dnBand2 - sigma;

   double ind1buffer[];
   CopyBuffer(ind1handler, 0, 1, 3, ind1buffer);
   double ind1val1 = ind1buffer[2];
   double ind1val2 = ind1buffer[1];
   bool ind1long  = ind1val1 < ind1val2 - sigma;
   bool ind1short = ind1long;

   const bool canOpenLong  = ind0long && ind1long;
   const bool canOpenShort = ind0short && ind1short;

   if(canOpenLong && canOpenShort) return;

   if(canOpenLong && getOpenPositionsFilter(pStrategyIndex) == false) {
      openBuyOrderAction(pStrategyIndex, pStopLossPoints, pTakeProfitPoints);
      posType_980 = OP_BUY;
   } else if(canOpenShort && getOpenPositionsFilter(pStrategyIndex) == false) {
      openSellOrderAction(pStrategyIndex, pStopLossPoints, pTakeProfitPoints);
      posType_980 = OP_SELL;
   }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void manageClose_980(int pStrategyIndex) {

   double Ind3Param1 = 0.78; // Level

   double ind2buffer0[];
   CopyBuffer(ind2handler, 0, 1, 2, ind2buffer0);
   double ind2buffer1[];
   CopyBuffer(ind21handler, 0, 1, 2, ind2buffer1);
   double ind2val1 = ind2buffer0[1];
   double ind2val2 = ind2buffer1[1];
   double ind2val3 = ind2buffer0[0];
   double ind2val4 = ind2buffer1[0];
   bool ind2long  = ind2val1 < ind2val2 - sigma && ind2val3 > ind2val4 + sigma;
   bool ind2short = ind2val1 > ind2val2 + sigma && ind2val3 < ind2val4 - sigma;

   double ind3buffer[];
   CopyBuffer(ind3handler, 0, 1, 3, ind3buffer);
   double ind3val1 = ind3buffer[2];
   double ind3val2 = ind3buffer[1];
   bool ind3long  = ind3val1 > Ind3Param1 + sigma && ind3val2 < Ind3Param1 - sigma;
   bool ind3short = ind3val1 < 1 - Ind3Param1 - sigma && ind3val2 > 1 - Ind3Param1 + sigma;

   double ind4buffer[];
   CopyBuffer(ind4handler, 0, 1, 3, ind4buffer);
   double ind4val1 = ind4buffer[2];
   double ind4val2 = ind4buffer[1];
   double ind4val3 = ind4buffer[0];
   bool ind4long  = ind4val1 > ind4val2 + sigma && ind4val2 < ind4val3 - sigma;
   bool ind4short = ind4val1 < ind4val2 - sigma && ind4val2 > ind4val3 + sigma;

   if(posType_980 == OP_BUY && (ind2long || ind3long || ind4long))
      closeOrderAction(pStrategyIndex);
   else if(posType_980 == OP_SELL && (ind2short || ind3short || ind4short))
      closeOrderAction(pStrategyIndex);

}
//+------------------------------------------------------------------+
