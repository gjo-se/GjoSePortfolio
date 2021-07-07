//+------------------------------------------------------------------+
//|                                                       Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+

input group                "---------- Basics ---------"
input long                  InpBaseMagicNumber = 5010600000;
input string               InpComment = "X5-Series";
input bool                 InpTradeOnNewBar = true;

input group                "---------- MoneyManagement ---------"
input bool                 InpUseMoneyManagement = false;
input double               InpLotsPerEquity = 0.01;
input double               InpFixedVolume = 0.1;

