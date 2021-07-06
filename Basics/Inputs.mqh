//+------------------------------------------------------------------+
//|                                                       Inputs.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+

input group                "---------- Basics ---------"
input int                  InpBaseMagicNumber = 5580000;
input string               InpComment = "Portfolio";
input bool                 InpTradeOnNewBar = true;

input group                "---------- MoneyManagement ---------"
input bool                 InpUseMoneyManagement = false;
input double               InpRiskPercent = 0;
input double               InpLotsPerEquity = 0.01;
input double               InpFixedVolume = 0.1;

