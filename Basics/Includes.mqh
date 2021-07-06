//+------------------------------------------------------------------+
//|                                                     Includes.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Includes                                                         |
//+------------------------------------------------------------------+
#include "Inputs.mqh"
#include "Const.mqh"

#include <Mql5Book\TradeHedge.mqh>
#include <Mql5Book\Pending.mqh>
#include <Mql5Book\Price.mqh>
#include <Mql5Book\MoneyManagement.mqh>
#include <Mql5Book\TrailingStops.mqh>
#include <Mql5Book\Timer.mqh>
#include <Mql5Book\Indicators.mqh>
#include <Trade\DealInfo.mqh>
#include <GjoSe\Tester\CustomOptimisation.mqh>

#include "Global.mqh"

#include "..\\Actions\\CleanArraysActions.mqh"
#include "..\\Actions\\OpenActions.mqh"
#include "..\\Actions\\CloseActions.mqh"

#include "..\\Strategies\\Strategy_892.mqh"

#include <GjoSe\\Utilities\\InclUtilities.mqh>
#include <GjoSe\\Objects\\InclLabel.mqh>
#include <GjoSe\\Objects\\InclRectangleLabel.mqh>
#include <GjoSe\\Objects\\InclHLine.mqh>
#include <GjoSe\\Objects\\InclVLine.mqh>
#include <GjoSe\\Objects\\InclTrendLine.mqh>
