/*
 * Copyright 2009 Andrew Eikum for CodeWeavers
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
 */

#define COBJMACROS

#include <stdio.h>

#include <hlink.h>

#include "wine/test.h"

static void test_SetInitialHlink(void)
{
    IHlinkBrowseContext *bc;
    IHlink *found_hlink;
    IMoniker *dummy, *found_moniker;
    IBindCtx *bindctx;
    WCHAR one[] = {'1',0};
    WCHAR five[] = {'5',0};
    WCHAR *found_name, *exp_name;
    HRESULT hres;

    hres = CreateBindCtx(0, &bindctx);
    ok(hres == S_OK, "CreateBindCtx failed: 0x%08x\n", hres);

    hres = CreateItemMoniker(one, five, &dummy);
    ok(hres == S_OK, "CreateItemMoniker failed: 0x%08x\n", hres);

    hres = IMoniker_GetDisplayName(dummy, bindctx, NULL, &exp_name);
    ok(hres == S_OK, "GetDisplayName failed: 0x%08x\n", hres);

    hres = HlinkCreateBrowseContext(NULL, &IID_IHlinkBrowseContext, (void**)&bc);
    ok(hres == S_OK, "HlinkCreateBrowseContext failed: 0x%08x\n", hres);

    hres = IHlinkBrowseContext_SetInitialHlink(bc, dummy, one, NULL);
    ok(hres == S_OK, "SetInitialHlink failed: 0x%08x\n", hres);

    hres = IHlinkBrowseContext_GetHlink(bc, HLID_CURRENT, &found_hlink);
    ok(hres == S_OK, "GetHlink failed: 0x%08x\n", hres);

    hres = IHlink_GetMonikerReference(found_hlink, HLINKGETREF_DEFAULT, &found_moniker, NULL);
    ok(hres == S_OK, "GetMonikerReference failed: 0x%08x\n", hres);

    hres = IMoniker_GetDisplayName(found_moniker, bindctx, NULL, &found_name);
    ok(hres == S_OK, "GetDisplayName failed: 0x%08x\n", hres);
    ok(!lstrcmpW(found_name, exp_name), "Found display name should have been %s, was: %s\n", wine_dbgstr_w(exp_name), wine_dbgstr_w(found_name));

    CoTaskMemFree(exp_name);
    CoTaskMemFree(found_name);

    IBindCtx_Release(bindctx);
    IMoniker_Release(found_moniker);
    IHlink_Release(found_hlink);
    IHlinkBrowseContext_Release(bc);
    IMoniker_Release(dummy);
}

static void test_BrowseWindowInfo(void)
{
    IHlinkBrowseContext *bc;
    HLBWINFO bwinfo_set, bwinfo_get;
    HRESULT hres;

    hres = HlinkCreateBrowseContext(NULL, &IID_IHlinkBrowseContext, (void**)&bc);
    ok(hres == S_OK, "HlinkCreateBrowseContext failed: 0x%08x\n", hres);

    hres = IHlinkBrowseContext_GetBrowseWindowInfo(bc, NULL);
    ok(hres == E_INVALIDARG, "GetBrowseWindow failed with wrong code: 0x%08x\n", hres);

    hres = IHlinkBrowseContext_SetBrowseWindowInfo(bc, NULL);
    ok(hres == E_INVALIDARG, "SetBrowseWindow failed with wrong code: 0x%08x\n", hres);

    memset(&bwinfo_get, -1, sizeof(HLBWINFO));

    hres = IHlinkBrowseContext_GetBrowseWindowInfo(bc, &bwinfo_get);
    ok(hres == S_OK, "GetBrowseWindowInfo failed: 0x%08x\n", hres);
    ok(bwinfo_get.cbSize == 0, "Got wrong size: %x\n", bwinfo_get.cbSize);

    bwinfo_set.cbSize = sizeof(HLBWINFO);
    bwinfo_set.grfHLBWIF = HLBWIF_WEBTOOLBARHIDDEN;
    bwinfo_set.rcFramePos.left = 1;
    bwinfo_set.rcFramePos.right = 2;
    bwinfo_set.rcFramePos.top = 3;
    bwinfo_set.rcFramePos.bottom = 4;
    bwinfo_set.rcDocPos.left = 5;
    bwinfo_set.rcDocPos.right = 6;
    bwinfo_set.rcDocPos.top = 7;
    bwinfo_set.rcDocPos.bottom = 8;
    bwinfo_set.hltbinfo.uDockType = 4321;
    bwinfo_set.hltbinfo.rcTbPos.left = 9;
    bwinfo_set.hltbinfo.rcTbPos.right = 10;
    bwinfo_set.hltbinfo.rcTbPos.top = 11;
    bwinfo_set.hltbinfo.rcTbPos.bottom = 12;
    hres = IHlinkBrowseContext_SetBrowseWindowInfo(bc, &bwinfo_set);
    ok(hres == S_OK, "SetBrowseWindowInfo failed: 0x%08x\n", hres);

    memset(&bwinfo_get, 0, sizeof(HLBWINFO));

    hres = IHlinkBrowseContext_GetBrowseWindowInfo(bc, &bwinfo_get);
    ok(hres == S_OK, "GetBrowseWindowInfo failed: 0x%08x\n", hres);
    ok(!memcmp(&bwinfo_set, &bwinfo_get, sizeof(HLBWINFO)), "Set and Get differ\n");

    IHlinkBrowseContext_Release(bc);
}

START_TEST(browse_ctx)
{
    CoInitialize(NULL);

    test_SetInitialHlink();
    test_BrowseWindowInfo();

    CoUninitialize();
}
