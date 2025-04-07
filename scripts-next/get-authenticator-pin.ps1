# Gets a time-based one time Authenticator PIN code
# This is a reduced/modified version of this code (MIT License)
# https://github.com/GregoireLD/Powershell-AuthGenerator.git
# MIT License

# Copyright (c) 2024 GregoireLD

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
function Get-AuthenticatorPin {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)]
        [string] $SecretKey,

        [ValidateSet(6,8)][int32] $digits = 6,

        [ValidateRange(1,120)][int32] $period = 30
    )

    $Base32Charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567'

    function Convert-Base32ToBytes {
        param ([string]$base32)
        $bigInteger = [Numerics.BigInteger]::Zero
        $cleanSecret = $base32.ToUpper() -replace '[^A-Z2-7]'
        foreach ($char in $cleanSecret.GetEnumerator()) {
            $bigInteger = ($bigInteger -shl 5) -bor ($Base32Charset.IndexOf($char))
        }
        [byte[]]$bytes = $bigInteger.ToByteArray()
        if ($bytes[-1] -eq 0) {
            $bytes = $bytes[0..($bytes.Count - 2)]
        }
        [array]::Reverse($bytes)
        return $bytes
    }

    $secretAsBytes = Convert-Base32ToBytes -base32 $SecretKey

    $epochTime = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
    $timeBytes = [BitConverter]::GetBytes([int64][math]::Floor($epochTime / $period))
    if ([BitConverter]::IsLittleEndian) {
        [array]::Reverse($timeBytes)
    }

    $hmacGen = [Security.Cryptography.HMACSHA1]::new($secretAsBytes)
    $hash = $hmacGen.ComputeHash($timeBytes)

    $offset = $hash[$hash.Length-1] -band 0xF
    $fourBytes = $hash[$offset..($offset+3)]
    if ([BitConverter]::IsLittleEndian) {
        [array]::Reverse($fourBytes)
    }

    $num = [BitConverter]::ToInt32($fourBytes, 0) -band 0x7FFFFFFF
    $pin = ($num % ([math]::Pow(10,$digits))).ToString().PadLeft($digits, '0')

    return $pin;
}